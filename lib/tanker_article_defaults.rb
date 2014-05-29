module TankerArticleDefaults
  def self.included(base)
    base.send(:include, ::Tanker)

    index = ENV['SEARCHIFY_API_INDEX']
    index = ENV['SEARCHIFY_API_INDEX'] if Rails.env === 'production'

    base.tankit index, :as => 'Article' do
      indexes :title
      indexes :title_es
      indexes :title_cn
      indexes :content_main
      indexes :content_main_es
      indexes :content_main_cn
      indexes :tags
      indexes :preview
      indexes :preview_es
      indexes :preview_cn

	    # NLP
	    indexes :metaphones do
	      keywords.map { |kw| kw.metaphone }
	    end
	    indexes :synonyms do
	      keywords.map { |kw| kw.synonyms.first(5) }
	    end
	    indexes :keywords do
	      keywords.map { |kw| kw.name }
	    end
	    indexes :stems do
	      keywords.map { |kw| kw.stem }
	    end
    end
  end
end
