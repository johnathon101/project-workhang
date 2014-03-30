class AddBannedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banned, :integer
  end
end
