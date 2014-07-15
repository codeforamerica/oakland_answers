class CreateUsers < ActiveRecord::Migration
  def change
    create_table "users", force: true do |t|
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_column :articles, :user_id, :integer
    add_column :categories, :user_id, :integer
  end
end
