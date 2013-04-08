class PhotoTemp < ActiveRecord::Base
  attr_accessible :album_id, :post_id, :photo_path
  belongs_to :user
  mount_uploader :photo_path, PhotoUploader
  #before_create :default_name

	def default_name
	  self.name ||= File.basename(image.filename, '.*').titleize if image
	end
end
