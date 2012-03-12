module Espresso
  class ArticlesController < Espresso::ApplicationController
    before_filter :find_article, :only => %w(show edit update destroy publish)
    before_filter :find_sections, :only => %w(new edit update create)

    def index
      @articles = Article.order('created_at DESC').page(params[:page])
    end

    def show
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new params[:article]
      if @article.save
        redirect_to articles_url, :notice => t('espresso.flash.articles.created')
      else
        render 'new'
      end
    end

    def edit
    end

    def update
      if @article.update_attributes(params[:article])
        redirect_to articles_url, :notice => t('espresso.flash.articles.updated')
      else
        render 'edit'
      end
    end

    def publish
      @article.publish!
      redirect_to articles_url, :notice => t('espresso.flash.articles.published')
    end

    def destroy
      @article.destroy
      redirect_to articles_url, :notice => t('espresso.flash.articles.destroyed')
    end

    private

    def find_article
      @article = Article.find params[:id]
    end

  end
end
