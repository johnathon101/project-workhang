class Projects < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text :projects
    end
  end
end
