module ApplicationHelper

	def official_site_title
		ENV["OFFICIAL_SITE_TITLE"]
	end

	def official_style_guide
		ENV["OFFICIAL_STYLE_GUIDE"]
	end

	def official_city_name
		ENV["OFFICIAL_CITY_NAME"]
	end

	def official_contact_email
		ENV["OFFICIAL_CONTACT_MAIL"]
	end

	def official_government_long_url(params = '')
		ENV["OFFICIAL_GOVERNMENT_URL"]
	end

	def official_government_short_url(params = '')
		File.basename(official_government_long_url) + params
	end

	def link_to_official_government_website(params = '', name = nil)
		name = name.nil? ? official_government_short_url : name
		link_to(name, "#{official_government_long_url}/#{params}")
	end
end
