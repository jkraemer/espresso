module Espresso
  class Comment < ActiveRecord::Base
    belongs_to :article, :class_name => "Espresso::Article", :foreign_key => "article_id"
    attr_accessible :name, :url, :body

    validates :name, :presence => true
    validates :body, :presence => true
  end
end
