class HomeController < ApplicationController
  def index
    @popular_categories = Category.order("access_count DESC").limit(4)
  end

 def about
 end

end
