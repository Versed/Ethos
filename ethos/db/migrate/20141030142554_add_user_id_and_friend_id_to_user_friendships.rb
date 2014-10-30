class AddUserIdAndFriendIdToUserFriendships < ActiveRecord::Migration
  def change
    add_column :user_friendships, :user_id, :integer
    add_index :user_friendships, :user_id
    add_column :user_friendships, :friend_id, :integer
    add_index :user_friendships, :friend_id
  end
end
