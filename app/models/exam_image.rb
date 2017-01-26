class ExamImage < ActiveRecord::Base
    belongs_to :exam
    mount_uploader :filename, ImageUploader
end
