require 'ffi/hunspell'

class SearchController < ApplicationController
  def index
    query =  params[:q].strip
    return redirect_to root_path if params[:q].blank?
    @query = query
    # spell check the query.
    @query_corrected = Article.spell_check query
    # remove puntuation and plurals.
    query = query.downcase.gsub(/[^\w]/, ' ').gsub(/ . /, ' ')
    # remove stop words
    query = Article.remove_stop_words query
    # Searchify can't handle requests longer than this (because of query expansion + Tanker inefficencies.  >10 can result in >8000 byte request strings)
    if query.split.size > 10 || query.blank?
      @query_corrected = query
      @results = []
      return
    end

    query_final = Article.expand_query( query )
    @results = Article.search_tank(query_final)
    Rails.logger.info "search-request: IP:#{request.env['REMOTE_ADDR']}, params[:query]:#{query}, QUERY:#{query_final}, FIRST_RESULT:#{@results.first.title unless @results.empty?}, RESULTS_N:#{@results.size}"

    respond_to do |format|
      format.json  { render @results }
      format.html
    end
  end

  def spell_check
    string = params[:string]

    dict_path = Rails.root.join("lib","assets","dict")
    en_aff_path = (dict_path + "en_US/en_US.aff").to_s
    en_dic_path = (dict_path + "en_US/en_US.dic").to_s
    blank_aff_path = (dict_path + "blank/blank.aff").to_s
    blank_dic_path = (dict_path + "blank/blank.dic").to_s

    dict = FFI::Hunspell::Dictionary.new(en_aff_path, en_dic_path)
    dict_custom = FFI::Hunspell::Dictionary.new(blank_aff_path, blank_dic_path)
    Keyword.all(:select => 'name').each do |kw|
      dict_custom.add kw.name
    end
    stop_words.each{ |sw| dict_custom.add(sw) }

    # perform the spell check
    string_corrected = string.split.map do |word|
      if dict.check?(word) or dict_custom.check?(word) # word is correct
        word
      else
        suggestion = dict_custom.suggest( word ).first
        suggestion.nil? ? word : suggestion
      end
    end


    respond_to do |format|
      format.json { render :json => string_corrected.join(' ') }
    end
  end

end
