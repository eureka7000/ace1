class Reply < ActiveRecord::Base

  belongs_to :question

  mount_uploader :content, ImageUploader

end
