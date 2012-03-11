module Espresso
  class SectionsController < ApplicationController
    before_filter :find_section, :only => %w(edit update destroy)
    before_filter :find_sections, :only => %w(index new edit update create)

    def index
      @sections = @sections.page(params[:page])
    end

    def edit
    end

    def update
      if @section.update_attributes(params[:section])
        redirect_to sections_path, :notice => t('espresso.flash.section.updated')
      else
        render 'edit'
      end
    end

    def new
      @section = Section.new :parent_id => params[:parent_id]
    end

    def create
      @section = Section.new params[:section]
      if @section.save
        redirect_to sections_path, :notice => t('espresso.flash.sections.created')
      else
        render 'new'
      end
    end

    def destroy
      if @section.destroy
        redirect_to sections_path, :notice => t('espresso.flash.sections.destroyed')
      else
        redirect_to sections_path, :alert => t('espresso.flash.sections.not_destroyed')
      end
    end

    private

    def find_section
      @section = Section.find params[:id]
    end

  end
end
