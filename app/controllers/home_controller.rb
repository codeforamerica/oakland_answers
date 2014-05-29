class HomeController < ApplicationController

  caches_page :index

  def index
    @popular_categories = Category.by_access_count.limit(4)
  end

 def about
 end

end
