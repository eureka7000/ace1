class AddGradeToConcepts < ActiveRecord::Migration
  def change
      add_column :concepts, :grade, :string
  end
end