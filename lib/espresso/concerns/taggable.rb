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

      module ClassMethods

        # returns a scope matching all taggables tagged with all of the given
        # tags
        def tagged_with(*tag_names)
          tags = tag_names.map{|name| Tag.find_by_name(name)}.compact

          if tags.blank? || tags.size < tag_names.size
            # no tags or non-existing tag given -> no results
            return scoped(:conditions => "1 = 0") 
          end

          # adapted from https://github.com/mbleigh/acts-as-taggable-on
          joins = tags.map do |tag|
            join_name = "`tag-#{tag.id}`"
            <<-SQL
              JOIN #{Tagging.table_name} #{join_name}
                ON #{join_name}.taggable_id = `#{table_name}`.#{primary_key}
                AND #{join_name}.taggable_type = #{quote_value(base_class.name)}
                AND #{join_name}.tag_id = #{tag.id}
            SQL
          end         

          scoped :joins => joins.join(' ')
        end
        
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
