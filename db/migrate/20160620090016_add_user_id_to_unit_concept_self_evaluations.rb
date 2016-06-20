class AddUserIdToUnitConceptSelfEvaluations < ActiveRecord::Migration
  def change
      
      add_column :unit_concept_self_evaluations, :user_id, :integer
      
  end
end
