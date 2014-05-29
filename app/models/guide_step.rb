class GuideStep < ActiveRecord::Base
		#  TODO guide step fields have diverged significantly from articles
		#  If we keep guide steps, need to customize which fields are indexed
		# include TankerArticleDefaults
    belongs_to :guide, :class_name => 'Guide', :foreign_key => 'article_id'
    attr_accessible :article_id, :title, :content, :preview, :step
end
