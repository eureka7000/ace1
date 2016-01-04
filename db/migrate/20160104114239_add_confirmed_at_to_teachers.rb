class AddConfirmedAtToTeachers < ActiveRecord::Migration
  def change
      
      remove_column :teachers, :comfirmed_id
      add_column :teachers, :confirmed_id, :integer      
      
  end
end
