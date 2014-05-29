class QuickAnswersController < ApplicationController

  def show
    return render(:template => 'articles/missing') unless QuickAnswer.exists? params[:id]

    @article = QuickAnswer.find(params[:id])
    return render(:template => 'articles/missing') unless @article.published?

    if request.path != quick_answer_path( @article )
      logger.info "Old permalink: #{request.path}"
      return redirect_to @article, :status => :moved_permanently
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

    @content_main_es =  @article.md_to_html( :content_main_es )
    @content_main_cn =  @article.md_to_html( :content_main_cn )


    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end
end
