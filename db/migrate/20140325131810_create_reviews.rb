class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :place_id
      t.text :title
      t.text :content

      t.timestamps
    end
  end
end
