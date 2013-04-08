class Status < ActiveRecord::Base
  attr_accessible :all_brackts, :branched_id, :global, :photo_id, :status, :photo_path
  belongs_to :user
  validates :user_id, presence: true
  validates :status, presence: true, length: { in: 1..300 } 
  mount_uploader :photo_path, PhotoUploader
end
