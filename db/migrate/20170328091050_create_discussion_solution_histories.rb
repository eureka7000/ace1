class CreateDiscussionSolutionHistories < ActiveRecord::Migration
  def change
    create_table :discussion_solution_histories do |t|
      t.integer :discussion_solution_id
      t.integer :user_id
      t.string :know_yn

      t.timestamps null: false
    end
  end
end
