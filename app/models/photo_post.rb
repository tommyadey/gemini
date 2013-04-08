class PhotoPost < ActiveRecord::Base
  attr_accessible :branched_id, :text, :user_id
end
