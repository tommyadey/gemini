class RemoveThumbsPathFromPhotoTemps < ActiveRecord::Migration
  def up
    remove_column :photo_temps, :thumbs_path
  end

  def down
    add_column :photo_temps, :thumbs_path, :string
  end
end
