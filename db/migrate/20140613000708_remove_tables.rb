class RemoveTables < ActiveRecord::Migration
  def up
    drop_table "contacts"
    drop_table "rails_admin_histories"
    drop_table "wordcounts"
    drop_table "keywords"
    drop_table "departments"

    remove_column :articles, :contact_id
  end

  def down
    create_table "contacts", :force => true do |t|
      t.string   "name"
      t.string   "subname"
      t.string   "number"
      t.string   "url"
      t.string   "address"
      t.string   "department"
      t.text     "description"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end

    create_table "rails_admin_histories", :force => true do |t|
      t.text     "message"
      t.string   "username"
      t.integer  "item"
      t.string   "table"
      t.integer  "month",      :limit => 2
      t.integer  "year",       :limit => 8
      t.datetime "created_at",              :null => false
      t.datetime "updated_at",              :null => false
    end

    add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

    create_table "keywords", :force => true do |t|
      t.string   "name"
      t.string   "metaphone"
      t.string   "stem"
      t.text     "synonyms"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "wordcounts", :force => true do |t|
      t.integer  "article_id"
      t.integer  "keyword_id"
      t.integer  "count"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    create_table "departments", :force => true do |t|
      t.string   "name"
      t.string   "acronym"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_column :articles, :contact_id, :integer
  end
end
