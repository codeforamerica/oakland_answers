# module RailsNlp
  module BigHugeThesaurus
    require 'json'
    require 'httparty'

    # attr_accessor :api_key

    # def self.auth( api_key=ENV['BHT_API_KEY'] )
    #   self.api_key = api_key
    # end

    def self.synonyms word
      if not ENV['BHT_API_KEY']
        raise Exception.new "You must set ENV['BHT_API_KEY'] = xxx, where xxx is your secret key for BigHugeThesaurus"
      end
      api_key = ENV['BHT_API_KEY']
      response = HTTParty.get "http://words.bighugelabs.com/api/2/#{api_key}/#{word}/json"
      return [] if response.nil?
      json = JSON.parse( response.body )
      synonyms = []
      json.keys.each do |key|
        synonyms.push json[key]['syn'].flatten
      end

      synonyms.flatten.uniq
    end
  end