class AddPlaceToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :place_id, :integer
  end
end
