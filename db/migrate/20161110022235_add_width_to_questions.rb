class AddWidthToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :width, :integer
  end
end
