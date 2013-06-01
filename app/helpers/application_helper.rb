module ApplicationHelper
	def categories_list
		Category.order('name')
	end
	def category_by_name(name)
		Category.where(:name => name).first
	end

	def offical_government_short_url
		ENV['OFFICIAL_GOVERMENT_URL']
	end

	def offical_government_long_url
		ENV['OFFICIAL_GOVERMENT_URL']
	end


	def link_offical_government
		link_to ( offical_government_short_url,  offical_government_long_url )
	end

end
