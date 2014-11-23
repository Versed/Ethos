class Skills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name

      t.integer :targetable_id
      t.string :targetable_type

      t.timestamps
    end

    add_index :skills, :name
    add_index :skills, [:targetable_id, :targetable_type]
  end
end
