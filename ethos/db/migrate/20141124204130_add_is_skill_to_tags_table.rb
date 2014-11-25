class AddIsSkillToTagsTable < ActiveRecord::Migration
  def change
    add_column :tags, :is_skill, :boolean
  end
end
