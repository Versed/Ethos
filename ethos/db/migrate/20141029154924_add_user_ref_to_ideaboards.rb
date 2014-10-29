class AddUserRefToIdeaboards < ActiveRecord::Migration
  def change
    remove_column :ideaboards, :user_id
    add_reference :ideaboards, :user, index: true
  end
end
