class AddGroupsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :group_id, :integer
  end
end
