class Bio < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text :bio
    end
  end
end
