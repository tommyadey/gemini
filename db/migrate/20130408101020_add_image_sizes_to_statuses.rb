class AddImageSizesToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :image_height, :integer
    add_column :statuses, :image_width, :integer
    add_column :statuses, :likes_count, :integer, :default => 0
    add_column :statuses, :replies_count, :integer, :default => 0
    add_column :statuses, :branches_count, :integer, :default => 0
  end
end
