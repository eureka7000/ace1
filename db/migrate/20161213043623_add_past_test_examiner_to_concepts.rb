class AddPastTestExaminerToConcepts < ActiveRecord::Migration
  def change
    add_column :concepts, :past_test_examiner, :string
  end
end
