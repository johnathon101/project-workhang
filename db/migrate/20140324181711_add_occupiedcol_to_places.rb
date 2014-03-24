class AddOccupiedcolToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :occupied, :boolean
  end
end
