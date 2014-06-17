class RemoveOldFieldsFromArticles < ActiveRecord::Migration
  def up
    remove_column "articles", "author_pic_file_name"
    remove_column "articles", "author_pic_content_type"
    remove_column "articles", "author_pic_file_size"
    remove_column "articles", "author_pic_updated_at"
    remove_column "articles",  "author_link"
    remove_column "articles", "content_main_extra"
    remove_column "articles", "content_need_to_know"
    remove_column "articles", "content"
    remove_column "articles", "content_md"
    remove_column "articles", "service_url"
  end

  def down
    add_column "articles", "author_pic_file_name", :string
    add_column "articles", "author_pic_content_type", :string
    add_column "articles", "author_pic_file_size", :integer
    add_column "articles", "author_pic_updated_at", :datetime
    add_column "articles", "author_link", :string
    add_column "articles", "content_main_extra", :text
    add_column "articles", "content_need_to_know", :text
    add_column "articles", "content", :text
    add_column "articles", "content_md", :text
    add_column "articles", "service_url", :string
  end
end
