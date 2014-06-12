class RemoveCanCanFields < ActiveRecord::Migration
  def up
    remove_column :users, :is_writer
    remove_column :users, :is_editor
    remove_column :users, :is_admin
  end

  def down
    add_column :users, :is_writer, :boolean, default: false
    add_column :users, :is_editor, :boolean, default: false
    add_column :users, :is_admin, :boolean, default: false
  end
end
