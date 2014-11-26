class AddStateToCollaborationTable < ActiveRecord::Migration
  def change
    add_column :collaborations, :state, :string
    add_index :collaborations, :state
  end
end
