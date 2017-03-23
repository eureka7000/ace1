class CreateDiscussionSolutions < ActiveRecord::Migration
  def change
    create_table :discussion_solutions do |t|
      t.integer :discussion_id
      t.text :content

      t.timestamps null: false
    end
  end
end
