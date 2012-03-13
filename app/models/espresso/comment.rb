require 'rdiscount'

module Espresso
  class Comment < ActiveRecord::Base
    belongs_to :article, :class_name => "Espresso::Article", :foreign_key => "article_id"
    attr_accessible :name, :url, :body

    validates :name, :presence => true
    validates :body, :presence => true
    validates :body_html, :presence => true

    before_validation :update_body_html

    private

    def update_body_html
      self.body_html = RDiscount.new(body).to_html
    end

  end
end
