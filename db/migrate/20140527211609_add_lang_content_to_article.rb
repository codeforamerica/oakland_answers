class AddLangContentToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :title_es, :string
    add_column :articles, :preview_es, :text
    add_column :articles, :content_main_es, :text
    add_column :articles, :title_cn, :string
    add_column :articles, :preview_cn, :text
    add_column :articles, :content_main_cn, :text
  end
end
