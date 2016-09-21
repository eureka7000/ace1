class Reply < ActiveRecord::Base

  belongs_to :question
  belongs_to :user
  
  validates_presence_of :user_id

  mount_uploader :file_name, ImageUploader

end
