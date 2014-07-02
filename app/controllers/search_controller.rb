class SearchController < ApplicationController
  respond_to :json, :html

  def index
    query =  params[:q].strip
    return redirect_to root_path if params[:q].blank?
    @query = query
    @results = Article.search(query).to_a
    respond_with(@results)
  end
end
