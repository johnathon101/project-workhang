class AddLatToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :lat, :float
  end
end
