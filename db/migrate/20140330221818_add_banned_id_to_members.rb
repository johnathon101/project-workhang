class AddBannedIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :banned_id, :integer
  end
end
