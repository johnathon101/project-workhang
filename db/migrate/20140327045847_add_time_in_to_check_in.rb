class AddTimeInToCheckIn < ActiveRecord::Migration
  def change
    add_column :check_ins, :time_in, :datetime
  end
end
