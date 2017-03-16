class AddConceptExplanationAndLevelToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :concept_explanation, :text
    add_column :discussions, :level, :integer
  end
end
