module ApplicationHelper
	def categories_list
		Category.order('name')
	end
	def category_by_name(name)
		Category.where(:name => name).first
	end




	def offical_site_title
		# "Oakland Answers"
		ENV['OFFICIAL_SITE_TITLE']
	end


	def offical_city_name
		ENV['OFFICIAL_CITY_NAME']
	end

	def offical_contact_email
		ENV['OFFICIAL_CONTACT_MAIL']
	end


	def offical_government_long_url(params)
		ENV['OFFICIAL_GOVERMENT_URL']
	end

	def offical_government_short_url(params)
		File.basename(offical_government_long_url) + params
	end


	def link_to_offical_government_website(params, name = nil)
		name = name.nil? ? offical_government_short_url : name
		link_to(name, "#{offical_government_long_url}/#{params}")
	end

end
