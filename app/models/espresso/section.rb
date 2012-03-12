module Espresso
  class Section < ActiveRecord::Base

    acts_as_nested_set :dependent => :destroy

    has_many :articles, :class_name => "Espresso::Article",
                        :foreign_key => "section_id",
                        :dependent => :destroy

    attr_accessible :name, :parent_id

    validates :name, :presence => true
    validates :slug, :format => /[\w-]+/, :allow_blank => true
    validates :path, :uniqueness => true

    before_validation :update_slug_and_path
    after_save :sort_rank

    scope :ordered, order('lft ASC')

    def self.[](path)
      find_by_path path
    end

    def self.root
      s = find_or_create_by_name_and_slug('ROOT', '')
      if s.persisted?
        s
      else
        raise "could not create root section: #{s.errors.full_messages}"
      end
    end

    def root?
      parent_id.nil? && slug.blank? && name == 'ROOT'
    end

    def empty?
      articles.blank?
    end


    protected

    # after inserting a new node, move it to the correct position so slugs on this level stay
    # ordered alphabetically.
    def sort_rank
      node = self
      previous_node = nil
      while node = node.left_sibling
        break if node.slug < slug
        previous_node = node
      end
      if node
        move_to_right_of node
      elsif previous_node
        move_to_left_of previous_node
      end
    end

    def update_slug_and_path
      self.slug = name.sluganize if !root?
      self.path = "#{parent.path + '/' if parent}#{slug}".gsub(/^\//, '')
    end

  end
end
