module Espresso
  class AssetsController < ApplicationController
    before_filter :find_asset, :only => %w(edit update destroy)

    def index
      @assets = Asset.by_date.page(params[:page])
      render 'index'
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
      @asset = Asset.new params[:asset]
      if @asset.save
        redirect_to assets_url(:view => params[:view], :page => params[:page]), :notice => t('espresso.flash.assets.created')
      else
        logger.error @asset.errors.full_messages
        index
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
