class Reply < ActiveRecord::Base

  belongs_to :question

  mount_uploader :file_name, ImageUploader

end
