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

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      flash[:error] = "Please add both a question and answer"
      render :new
    end
  end

  def edit
    @article = Article.friendly.find(params[:id])
  end

  def update
    @article = Article.friendly.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to article_path(@article)
    else
      flash[:error] = "Please add both a question and answer"
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content_main, :author_name, :bootsy_image_gallery_id)
  end
end
