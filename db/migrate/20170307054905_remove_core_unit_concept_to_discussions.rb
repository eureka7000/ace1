class RemoveCoreUnitConceptToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :core_unit_concept, :integer
  end
end
