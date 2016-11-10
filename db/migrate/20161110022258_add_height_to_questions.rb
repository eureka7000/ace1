class AddHeightToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :height, :integer
  end
end
