class WebServicesController < ApplicationController

  def show
    return render(:template => 'articles/missing') unless WebService.exists? params[:id]

    @article = WebService.find(params[:id])

    return render(:template => 'articles/missing') unless @article.published?

    if request.path != web_service_path( @article )
      logger.info "Old permalink: #{request.path}"
      return redirect_to @article, status: :moved_permanently
    end

    @article.delay.increment! :access_count
    @article.delay.category.increment!(:access_count) if @article.category

    unless @article.render_markdown
      @content_html = @article.content
      render :show_html and return
    end

    @content_main =  @article.md_to_html( :content_main )
    @content_main_extra = @article.md_to_html( :content_main_extra )
    @content_need_to_know =  @article.md_to_html( :content_need_to_know )

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end
end
