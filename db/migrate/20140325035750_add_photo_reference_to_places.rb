class AddPhotoReferenceToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :photoref, :text
  end
end
