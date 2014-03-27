class AddGroupsToCheckIn < ActiveRecord::Migration
  def change
    add_column :check_ins, :group_id, :integer
  end
end
