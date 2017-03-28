class CreateDiscussionTitleExplanationHistories < ActiveRecord::Migration
  def change
    create_table :discussion_title_explanation_histories do |t|
      t.integer :discussion_title_explanation_id
      t.integer :user_id
      t.string :know_yn

      t.timestamps null: false
    end
  end
end
