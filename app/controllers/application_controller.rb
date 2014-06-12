class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all

  def stop_words
    @stop_words ||= Rails.cache.fetch('stop_words') do
      CSV.read( "lib/assets/eng_stop.csv" ).flatten
    end
  end
end
