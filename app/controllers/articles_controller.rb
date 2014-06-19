class ArticlesController < ApplicationController
  respond_to :json, :html

  def show
    @article = Article.friendly.find(params[:id])
    respond_with(@article)
  end

  def index
    @categories = Category.by_access_count
    respond_with(@categories)
  end
end
