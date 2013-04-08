class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :name
      t.integer :photo_count
      t.boolean :global, :default => false
      t.boolean :all_brackts, :default => false
      t.integer :total_likes, :default => 0
      t.integer :total_comments, :default => 0

      t.timestamps
    end
  end
end
