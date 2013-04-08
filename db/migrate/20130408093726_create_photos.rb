class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.integer :user_id, :null => false
    	t.integer :album_id, :default => 0
    	t.integer :photo_post_id, :default => 0
    	t.string  :text
    	t.string  :photo_path
    	t.integer :height
    	t.integer :width
    	t.integer :likes_count, :default => 0
    	t.integer :comments_count, :default => 0

      	t.timestamps
    end
    add_index :photos, :user_id
    add_index :photos, :album_id
    add_index :photos, :photo_post_id
  end
end
