class RemoveOldFieldsFromArticles < ActiveRecord::Migration
  def up
    remove_column "articles", "content_main_extra"
    remove_column "articles", "content_need_to_know"
    remove_column "articles", "content"
    remove_column "articles", "content_md"
    remove_column "articles", "service_url"
  end

  def down
    add_column "articles", "content_main_extra", :text
    add_column "articles", "content_need_to_know", :text
    add_column "articles", "content", :text
    add_column "articles", "content_md", :text
    add_column "articles", "service_url", :string
  end
end
