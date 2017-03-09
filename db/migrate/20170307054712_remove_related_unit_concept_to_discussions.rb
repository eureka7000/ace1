class RemoveRelatedUnitConceptToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :related_unit_concept, :integer
  end
end
