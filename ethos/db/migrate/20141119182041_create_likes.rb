class CreateLikes < ActiveRecord::Migration
  def change
    add_column :users, :like_id, :integer
    add_column :ideaboards, :like_id, :integer

    create_table :likes do |t|
      t.integer :like_id, index: true
      t.integer :user_id
      t.integer :ideaboard_id

      t.timestamps
    end
  end
end
