class RemoveTitleAndContentAndAnswerAndGradeAndUnitConceptIdAndLevelToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :title, :text
    remove_column :discussions, :content, :text
    remove_column :discussions, :answer, :text
    remove_column :discussions, :grade, :string
    remove_column :discussions, :unit_concept_id, :integer
    remove_column :discussions, :level, :integer
  end
end
