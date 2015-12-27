class AddIsSchoolToSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :is_school
    add_column :schools, :is_school, :string
  end
end
