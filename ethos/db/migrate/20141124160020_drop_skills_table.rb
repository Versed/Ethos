class DropSkillsTable < ActiveRecord::Migration
  def change
    drop_table :skills
    drop_table :tags
  end
end
