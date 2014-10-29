class AddTitleToIdeaboard < ActiveRecord::Migration
  def change
    add_column :ideaboards, :title, :string
  end
end
