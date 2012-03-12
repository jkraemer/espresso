class BlogController < ApplicationController

  def index
    @articles = Espresso::Section.root.
                  articles.published.order('published_at DESC').page(params[:page]).per(10)
  end

  def show
    if @section = Espresso::Section[params[:path]]
      render 'index'
    else
      unless @article = Espresso::Article[params[:path]]
        raise ActiveRecord::RecordNotFound
      end
    end
  end

end
