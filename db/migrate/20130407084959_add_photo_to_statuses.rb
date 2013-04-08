class AddPhotoToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :photo_path, :string, :default => 0
  end
end
