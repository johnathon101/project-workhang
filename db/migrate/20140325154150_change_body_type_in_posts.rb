class ChangeBodyTypeInPosts < ActiveRecord::Migration
  def change
    change_column :users, :phone_num, :bigint
  end
end
