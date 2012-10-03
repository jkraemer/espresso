require 'rdiscount'
require 'coderay'

module Espresso
  class Article < ActiveRecord::Base
    belongs_to :section, :class_name => "Espresso::Section"
    has_and_belongs_to_many :tags, :class_name => 'Espresso::Tag', :join_table => "espresso_taggings"
    has_many :comments, :class_name => "Espresso::Comment", :foreign_key => "article_id",
                        :order => 'created_at ASC', :dependent => :destroy

    attr_accessor :tag_names, :publish

    attr_accessible :title, :body, :slug, :section_id, :tag_names, :publish

    validates :title, :presence => true
    validates :slug, :presence => true, :unless => 'title.blank?'
    validates :path, :presence => true, :uniqueness => true
    validates :body, :presence => true
    validates :body_html, :presence => true
    validates :section_id, :presence => true

    before_validation :update_body_html
    before_validation :set_default_section
    before_validation :update_slug_and_path
    before_validation :publish_if_checkbox_checked
    after_save :update_taggings

    scope :published, lambda{ where('published_at IS NOT NULL AND published_at <= ?', Time.now) }
    scope :for_year, lambda { |year|
      beg_of_year = Time.parse("#{year}-01-01")
      where('published_at between ? AND ?', beg_of_year, beg_of_year.end_of_year)
    }

    delegate :show_pub_date?, :to => :section

    def update_taggings
      if @tag_names
        new_tags = tag_names.split(',').map{|t| t.strip.squeeze(' ') }.map do |t|
          Tag.find_or_create_by_name t
        end
        @tag_names = nil
        self.update_attribute :tags, new_tags
      end
    end

    def tag_names
      @tag_names ||= tags.map(&:name).join(', ')
    end

    def publish!
      update_attribute :published_at, Time.now
    end

    def published?
      published_at.present? && published_at <= Time.now
    end

    def self.[](path)
      published.find_by_path(path)
    end

    protected

    def publish_if_checkbox_checked
      self.published_at = Time.now if ['1', true, 'true'].include?(publish) && !self.published_at.present?
    end

    def set_default_section
      self.section = Section.root if section_id.blank? && section.blank?
    end

    def update_body_html
      self.body_html = RDiscount.new(code_ray(body)).to_html
    end

    def code_ray(text)
      text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
        CodeRay.scan($3, $2).div
      end
    end

    def update_slug_and_path
      self.slug = title.sluganize if slug.blank?
      self.path = "#{section.path}/#{slug}".gsub(/^\//, '')
    end

  end
end
