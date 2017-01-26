class AddExamImageIdToExams < ActiveRecord::Migration
  def change
    add_column :exams, :exam_image_id, :string
  end
end
