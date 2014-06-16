class RemoveGuideSteps < ActiveRecord::Migration
  def up
    drop_table "guide_steps"
end

  def down
    create_table "guide_steps", :force => true do |t|
      t.integer  "article_id"
      t.string   "title"
      t.text     "content"
      t.text     "preview"
      t.integer  "step"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
