class QuickAnswersController < ApplicationController
  respond_to :json, :html

  def show
    @article = Article.friendly.find(params[:id])

    if @article.nil? || !@article.published?
      return render(:template => 'articles/missing')
    end

    if request.path != quick_answer_path( @article )
      logger.info "Old permalink: #{request.path}"
      return redirect_to @article, :status => :moved_permanently
    end

    @article.delay.increment! :access_count
    @article.delay.category.increment!(:access_count) if @article.category

    #  TODO OMG, this is terrible, need to fix
    unless @article.render_markdown
      @content_html = @article.content
      render :show_html and return
    end

    @content_main =     @article.md_to_html( :content_main )
    @content_main_es =  @article.md_to_html( :content_main_es )
    @content_main_cn =  @article.md_to_html( :content_main_cn )


    respond_with(@article)
  end
end
