module Espresso
  class AssetsController < ApplicationController
    before_filter :find_asset, :only => %w(edit update destroy)

    def index
      @assets = Asset.by_date.page(params[:page])
      render 'index'
    end

    def thumbnails
      @assets = Asset.by_date.page(params[:page])
    end

    def edit
    end

    def update
      if @asset.update_attributes(params[:asset])
        redirect_to assets_url, :notice => t('espresso.flash.assets.updated')
      else
        render 'edit'
      end
    end

    def create
      if params[:asset]
        # standard form
        @asset = Asset.new params[:asset]
        if @asset.save
          redirect_to assets_url(:view => params[:view], :page => params[:page]), :notice => t('espresso.flash.assets.created')
        else
          logger.error @asset.errors.full_messages
          index
        end
      elsif params[:files]
        # jquery multi-file-upload
        json = params[:files].map do |file|
          Asset.create :file => file
        end.map do |asset|
          asset.to_jq_upload request
        end.to_json
        respond_to do |format|
          format.html {
            # support iframe upload for crappy browsers
            render :json => json, :content_type => 'text/html', :layout => false
          }
          format.json {
            render :json => json
          }
        end
      else
        redirect_to assets_url
      end
    end

    def destroy
      @asset.destroy
      redirect_to assets_url, :notice => t('espresso.flash.assets.destroyed')
    end

    private

    def find_asset
      @asset = Asset.find params[:id]
    end
  end
end
