class QuickAnswersController < ApplicationController
  add_breadcrumb "Home", :root_url
  
  def show
    
    unless QuickAnswer.exists? params[:id]
      add_breadcrumb "(404) Page not found"
      return render(:template => 'articles/missing') 
    end

    @article = QuickAnswer.find(params[:id])
    
    unless @article.published?
      add_breadcrumb "(404) Page not found"
      return render(:template => 'articles/missing') 
    end

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
    
    if @article.category.present?
      add_breadcrumb @article.category.name, @article.category
    end
    add_breadcrumb @article.title

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
