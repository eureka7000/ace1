class RemoveConceptExplanationToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :concept_explanation, :text
  end
end
