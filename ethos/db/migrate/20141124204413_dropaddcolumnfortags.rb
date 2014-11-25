class Dropaddcolumnfortags < ActiveRecord::Migration
  def change
    remove_column :tags, :is_skill
    add_column :tags, :is_skill, :boolean, default: true
  end
end
