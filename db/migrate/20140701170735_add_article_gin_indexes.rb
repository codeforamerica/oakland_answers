class AddArticleGinIndexes < ActiveRecord::Migration
  def up
    execute "CREATE INDEX index_articles_on_content_main ON articles USING gin(to_tsvector('english', content_main))"
    execute "CREATE INDEX index_articles_on_title ON articles USING gin(to_tsvector('english', title))"
    execute "CREATE INDEX index_articles_on_content_main_es ON articles USING gin(to_tsvector('spanish', content_main_es))"
    execute "CREATE INDEX index_articles_on_title_es ON articles USING gin(to_tsvector('spanish', title_es))"
  end

  def down
    execute "DROP INDEX index_articles_on_content_main"
    execute "DROP INDEX index_articles_on_title"
    execute "DROP INDEX index_articles_on_content_main_es"
    execute "DROP INDEX index_articles_on_title_es"
  end
end
