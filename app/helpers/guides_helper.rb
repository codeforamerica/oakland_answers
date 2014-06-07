module GuidesHelper
  def meta_tag_hash(article)
  	{ description: article.preview,
      canonical: ENV["OFFICIAL_GOVERNMENT_URL"] + request.fullpath,
      title: set_meta_tags_title(article) }
  end

  private

  def set_meta_tags_title(article)
  	article.category.nil? ? [article.title] : [article.category.name, article.title]  
  end
end
