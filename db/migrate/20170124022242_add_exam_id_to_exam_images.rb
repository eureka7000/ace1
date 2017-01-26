class AddExamIdToExamImages < ActiveRecord::Migration
  def change
    add_column :exam_images, :exam_id, :integer
  end
end
