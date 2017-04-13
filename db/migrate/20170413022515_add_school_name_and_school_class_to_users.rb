class AddSchoolNameAndSchoolClassToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_name, :string
    add_column :users, :school_class, :string
  end
end
