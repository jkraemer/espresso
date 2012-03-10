module Espresso
  class Section < ActiveRecord::Base
    belongs_to :parent, :class_name => "Espresso::Section", :foreign_key => "parent_id"
    has_many :children, :class_name => "Espresso::Section", :foreign_key => "parent_id", :dependent => :destroy
    has_many :articles, :class_name => "Espresso::Article", :foreign_key => "section_id", :dependent => :destroy

    attr_accessible :name, :parent_id

    validates :name, :presence => true
    validates :slug, :format => /[\w-]+/, :allow_blank => true, :uniqueness => { :scope => :parent_id }

    before_validation :update_slug

    scope :by_slug, order('slug ASC')

    def hierarchy
      ([self] + children.by_slug.map{|s| s.hierarchy}).flatten
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

    def full_slug
      if parent
        [parent.full_slug, slug].join('/').gsub %r{^//}, '/'
      else
        '/'
      end
    end

    def empty?
      articles.blank?
    end

    protected

    def update_slug
      self.slug = name.sluganize if !root?
    end

  end
end
