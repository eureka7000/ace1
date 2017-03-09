class RemoveExamImageIdToExams < ActiveRecord::Migration
  def change
    remove_column :exams, :exam_image_id, :string
  end
end
