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
    end
  end
end
