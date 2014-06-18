class ArticlesController < ApplicationController
  respond_to :json

  def index
    @bodyclass = "results"
    @categories = Category.by_access_count

    respond_with(@categories)
  end

  def show
    # redirect to the new paths (such as /quick_answers/1 instead of /articles/1)
    @article = Article.friendly.find(params[:id])
    return redirect_to quick_answer_path(@article.id), status: :moved_permanently
  end

  def article_type
    @article_type = params[:content_type]
    @article_type = @article_type.gsub(/-/, ' ').titlecase.gsub(/ /, '')
    @articles = Article.find_by_type(@article_type)
  end
end
