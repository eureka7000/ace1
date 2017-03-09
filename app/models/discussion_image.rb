class DiscussionImage < ActiveRecord::Base
  belongs_to :discussion
  mount_uploader :filename, ImageUploader
end
