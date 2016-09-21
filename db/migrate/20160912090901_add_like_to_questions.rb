class AddLikeToQuestions < ActiveRecord::Migration
  def change
      add_column :questions, :like, :integer
  end
end
