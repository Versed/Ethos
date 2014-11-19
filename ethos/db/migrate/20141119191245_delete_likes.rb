class DeleteLikes < ActiveRecord::Migration
  def change
    drop_table :likes
    remove_column :users, :like_id
    remove_column :ideaboards, :like_id
  end
end
