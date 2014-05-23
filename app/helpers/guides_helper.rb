module GuidesHelper
  def meta_tag_hash(article)
  	{ description: article.preview,
      canonical: official_government_long_url(request.fullpath),
      title: set_meta_tags_title(article) }
  end

  private

  def set_meta_tags_title(article)
  	article.category.nil? ? [article.title] : [article.category.name, article.title]  
  end
end
