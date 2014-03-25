class RemoveLngFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :lng
  end

  def down
    add_column :places, :lng, :integer
  end
end
