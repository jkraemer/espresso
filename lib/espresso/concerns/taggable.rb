module Espresso
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do
        has_many :taggings, :as => :taggable, :class_name => 'Espresso::Tagging', :dependent => :delete_all
        has_many :tags, :through => :taggings, :class_name => 'Espresso::Tag'
        attr_writer :tag_names
        attr_accessible :tag_names
        after_save :update_taggings
      end

      def tag_names
        tags.map(&:name).join(', ')
      end

      protected

      def update_taggings
        if @tag_names
          taggings.delete_all
          @tag_names.split(',').map{|t| t.strip.squeeze(' ') }.map do |t|
            tag(t)
          end
        end
      end

      def tag(name)
        tag = Tag.find_or_create_by_name(name)
        self.taggings.find_or_create_by_tag_id(tag.id)
      end

    end
  end
end
