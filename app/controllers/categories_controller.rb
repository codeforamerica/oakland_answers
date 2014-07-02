class CategoriesController < ApplicationController
  respond_to :json, :html
  def index
    @categories = Category.by_access_count
    respond_with(@categories)
  end

  def show
    @category = Category.friendly.find(params[:id])
    @category.increment! :access_count
    respond_with(@category)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New category created"
      redirect_to category_path(@category)
    else
      flash.now[:error] = "Please fill in all required fields"
      render :new
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category successfully updated"
      redirect_to category_path(@category)
    else
      flash.now[:error] = "Please fill in all required fields"
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
