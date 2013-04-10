class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :author_id
      t.string :status
      t.integer :photo_id, :default => 0
      t.integer :branched_id, :default => 0
      t.boolean :global, :default => false
      t.boolean :all_brackts, :default => false

      t.timestamps
    end
    add_index :statuses, [:author_id, :created_at, :branched_id]
  end
end
