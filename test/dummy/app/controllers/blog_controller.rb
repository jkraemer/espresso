class BlogController < ApplicationController
  before_filter :find_section_or_article, :only => %w(show create_comment)

  def index
    @articles = Espresso::Section.root.
                  articles.published.order('published_at DESC').page(params[:page]).per(10)
  end

  def show
    render 'index' if @section
  end

  def create_comment
    if @article
      @comment = @article.comments.build params[:comment]
      @comment.approved = true
      @comment.author_ip = request.remote_ip
      if @comment.save
        redirect_to article_path(:path => @article.path), :notice => 'Thank you!'
      else
        flash.now[:error] = 'Your comment could not be saved.'
      end
    else
      raise ActiveRecord::RecordNotFound
    end
  end


  private

  def find_section_or_article
    unless @section = Espresso::Section[params[:path]]
      raise ActiveRecord::RecordNotFound unless @article = Espresso::Article[params[:path]]
    end
  end
end
