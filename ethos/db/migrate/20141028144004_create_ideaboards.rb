class CreateIdeaboards < ActiveRecord::Migration
  def change
    create_table :ideaboards do |t|
      t.integer :user_id,
      t.timestamps
    end

    add_index :ideaboards, :user_id
  end
end
