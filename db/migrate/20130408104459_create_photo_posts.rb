class CreatePhotoPosts < ActiveRecord::Migration
  def change
    create_table :photo_posts do |t|
      t.integer :user_id
      t.string :text
      t.integer :branched_id, :default => 0
      t.boolean :global, :default => false
      t.boolean :all_brackts, :default => false
      t.integer :photo_count
      t.integer :likes_count, :default => 0
      t.integer :comments_count, :default => 0
      t.integer :branches_count, :default => 0

      t.timestamps
    end
  end
end
