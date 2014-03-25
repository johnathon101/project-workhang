class AddMoreColumns < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :twitter
      t.string :website
      t.boolean :mentor
    end
  end
end
