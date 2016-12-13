class AddPastTestScoreToConcepts < ActiveRecord::Migration
  def change
    add_column :concepts, :past_test_score, :string
  end
end
