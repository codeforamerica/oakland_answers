class GuidesController < ApplicationController
	def show
		return render(:template => 'articles/missing') unless Guide.exists? params[:id]
		@article = Guide.find(params[:id])

		return render(:template => 'articles/missing') unless @article.published?
    if request.path != guide_path( @article )
      logger.info "Old permalink: #{request.path}"
      return redirect_to @article, status: :moved_permanently
    end

    @article.delay.increment! :access_count
    @article.delay.category.increment!(:access_count) if @article.category

    if !@article.render_markdown
      @content_html = @article.content
	      hr = /<hr( \/)?>/
        if @content_html.match hr
          @content_html.gsub!(hr,"</div>")
          @content_html = "<div class='quick_top'>" + @content_html
        end
      render :show_html and return
    end

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end
end
