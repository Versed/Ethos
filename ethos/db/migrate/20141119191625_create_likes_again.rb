class CreateLikesAgain < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :ideaboard, index: true
      t.references :user
      t.integer :like_id
    end
  end
end
