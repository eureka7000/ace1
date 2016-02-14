class AddFileNameToExplanations < ActiveRecord::Migration
  def change
      add_column :explanations, :file_name, :string      
  end
end
