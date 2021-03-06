module Espresso
  class ApplicationController < ActionController::Base

    layout 'espresso/application'

    protected

    def find_sections
      Section.root # ensure the root section exists
      # @sections = Section.root.hierarchy
      @sections = Section.order('lft ASC')
    end

  end
end
