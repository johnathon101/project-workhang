class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :fname
      t.text :lname
      t.string :email
      t.string :password_digest
      t.integer :phone_num

      t.timestamps
    end
  end
end
