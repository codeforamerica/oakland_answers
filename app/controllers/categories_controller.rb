class CategoriesController < ApplicationController
  respond_to :json, :html
  def index
  	@bodyclass = "results"

    @categories = Category.by_access_count
    respond_with(@categories)
  end

  def show
    @category = Category.friendly.find(params[:id])
      return render(:template => 'categories/missing') if @category.nil?

    # redirection of old permalinks
    if request.path != category_path( @category )
      logger.info "Old permalink: #{request.path}"
      return redirect_to @category, status: :moved_permanently
    end

    @category.delay.increment! :access_count

    @content_html = BlueCloth.new(@category.name).to_html
    @bodyclass = "results"

    respond_with(@category)
  end

  def missing
    render :layout => 'missing'
  end
end
