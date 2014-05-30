require 'httparty'
require 'cgi'
require 'time'

class Temporize
  include HTTParty
  base_uri 'https://api.temporize.net/v1'
  format :json
  attr_accessor :credentials

  def initialize
    @credentials = {username: ENV['TEMPORIZE_USERNAME'], password: ENV['TEMPORIZE_PASSWORD']}
  end

  def do_reindex
    cron = CGI::escape("*/2 * * * *")
    search_reindex_url = ENV["SEARCH_REINDEX_URL"]
    url = CGI::escape(search_reindex_url)
    Temporize.post("/events/#{cron}/#{url}", basic_auth: credentials)
  end
end
