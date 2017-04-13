class AddInstituteNameAndInstituteClassToUsers < ActiveRecord::Migration
  def change
    add_column :users, :institute_name, :string
    add_column :users, :institute_class, :string
  end
end
