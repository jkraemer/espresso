module Espresso
  class Tagging < ActiveRecord::Base
    attr_accessible :tag_id, :taggable_id, :taggable_type

    belongs_to :tag, :class_name => 'Espresso::Tag'
    belongs_to :taggable, :polymorphic => true
  end
end
