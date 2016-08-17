class AddLevelToConcepts < ActiveRecord::Migration
  def change
      
      remove_column :concepts, :grade
      add_column :concepts, :grade, :integer
      add_column :concepts, :level, :integer
      
  end
end
