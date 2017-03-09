class AddUnitConceptIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :unit_concept_id, :integer
  end
end
