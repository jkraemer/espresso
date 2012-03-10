require 'rdiscount'
require 'coderay'

module Espresso
  class Article < ActiveRecord::Base
    belongs_to :section, :class_name => "Espresso::Section"
    has_and_belongs_to_many :tags, :join_table => "espresso_taggings"

    attr_accessor :tag_names, :publish

    attr_accessible :title, :body, :section_id, :tag_names

    validates :title, :presence => true
    validates :slug, :presence => true
    validates :body, :presence => true
    validates :body_html, :presence => true
    validates :section_id, :presence => true

    before_validation :update_body_html
    before_validation :update_slug
    before_validation :set_default_section

    scope :published, where('published_at IS NOT NULL AND published_at <= ?', Time.now)

    def publish!
      update_attribute :published_at, Time.now
    end

    def published?
      published_at.present? && published_at <= Time.now
    end

    protected

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

    def update_slug
      self.slug = title.sluganize
    end

  end
end
