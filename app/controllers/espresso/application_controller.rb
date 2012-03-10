module Espresso
  class ApplicationController < ActionController::Base

    protected

    def find_sections
      Section.root # ensure the root section exists
      @sections = Section.root.hierarchy
    end

  end
end
