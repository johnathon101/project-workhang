class RemoveLatFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :lat
  end

  def down
    add_column :places, :lat, :integer
  end
end
