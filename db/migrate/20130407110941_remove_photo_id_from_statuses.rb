class RemovePhotoIdFromStatuses < ActiveRecord::Migration
  def up
    remove_column :statuses, :photo_id
  end

  def down
    add_column :statuses, :photo_id, :integer
  end
end
