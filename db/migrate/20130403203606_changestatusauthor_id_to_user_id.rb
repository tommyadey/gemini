class ChangestatusauthorIdToUserId < ActiveRecord::Migration
  def change
  	rename_column :statuses, :author_id, :user_id
  end
end
