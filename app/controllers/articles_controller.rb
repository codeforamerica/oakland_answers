class ArticlesController < ApplicationController
  before_action :require_signin
  skip_before_action :require_signin, only: [:show, :index]
  respond_to :json, :html

  def show
    @article = Article.friendly.find(params[:id])
    respond_with(@article)
  end

  def index
    @categories = Category.by_access_count
    @categories = @categories.select{ |c| c.articles.published.count > 0 }
    respond_with(@categories)
  end

  def new
    @article = Article.new
  end

  def create
    # All articles will by default be published immediately
    @article = Article.new(article_params.merge({status: "Published", user: @current_user}))
    if @article.save
      flash[:success] = "New question and answer successfully created"
      redirect_to article_path(@article)
    else
      flash.now[:error] = "Please fill in all required fields"
      render :new
    end
  end

  def edit
    @article = Article.friendly.find(params[:id])
  end

  def update
    @article = Article.friendly.find(params[:id])
    if @article.update_attributes(article_params.merge({user: @current_user}))
      flash[:success] = "Question and answer successfully updated"
      redirect_to article_path(@article)
    else
      flash.now[:error] = "Please fill in all required fields"
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content_main, :title_es, :content_main_es, :title_cn, :content_main_cn, :author_name, :author_link, :category_id, :user)
  end

  def require_signin
    if current_user.nil?
      redirect_to root_path
    end
  end
end
