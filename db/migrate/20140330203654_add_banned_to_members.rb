class AddBannedToMembers < ActiveRecord::Migration
  def change
    add_column :members, :banned, :integer
  end
end
