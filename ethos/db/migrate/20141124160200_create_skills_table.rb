class CreateSkillsTable < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name

      t.integer :skillable_id
      t.string :skillable_type

      t.timestamps
    end

    add_index :skills, :name
    add_index :skills, [:skillable_id, :skillable_type]
  end
end
