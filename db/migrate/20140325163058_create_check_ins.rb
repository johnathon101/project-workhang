class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :user_id
      t.integer :place_id
      t.timestamp :time_out

      t.timestamps
    end
  end
end
