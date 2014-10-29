class AddDescriptionToIdeaboard < ActiveRecord::Migration
  def change
    add_column :ideaboards, :description, :text
  end
end
