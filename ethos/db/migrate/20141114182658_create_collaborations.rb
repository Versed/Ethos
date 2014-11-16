class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.integer :ideaboard_id
      t.integer :user_id

      t.timestamps
    end

    add_index :collaborations, :ideaboard_id
  end
end
