class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :desc
      t.string :street
      t.string :city
      t.integer :zipcode
      t.string :hours
      t.integer :user_id
      t.integer :review_id
      t.integer :lat
      t.integer :lng
      t.boolean :occupied

      t.timestamps
    end
  end
end
