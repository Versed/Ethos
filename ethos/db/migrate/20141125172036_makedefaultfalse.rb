class Makedefaultfalse < ActiveRecord::Migration
  def change
    change_column :tags, :is_skill, :boolean, default: false
  end
end
