class CreatePhotoTemps < ActiveRecord::Migration
  def change
    create_table :photo_temps do |t|
    	t.integer :user_id, :null => false
    	t.integer :album_id, :default => 0
    	t.integer :post_id, :default => 0
    	t.string  :photo_path
    	t.string  :thumbs_path
    	t.integer :height
    	t.integer :width

      	t.timestamps
    end
    add_index :photo_temps, :user_id
    add_index :photo_temps, :album_id
    add_index :photo_temps, :post_id
  end
end
