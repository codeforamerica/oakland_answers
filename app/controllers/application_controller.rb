class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user
  helper :all

  def stop_words
    @stop_words ||= Rails.cache.fetch('stop_words') do
      CSV.read( "lib/assets/eng_stop.csv" ).flatten
    end
  end

  def current_user
    User.find_by_email(session[:email])
  end

  def set_current_user
    @current_user = current_user
  end

  def require_login
    if current_user.nil?
      redirect_to root_url
    end
  end
end
