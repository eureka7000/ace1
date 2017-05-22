class CreateDiscussionProblemConditions < ActiveRecord::Migration
  def change
    create_table :discussion_problem_conditions do |t|
      t.text :problem_condition
      t.text :condition_answer

      t.timestamps null: false
    end
  end
end
