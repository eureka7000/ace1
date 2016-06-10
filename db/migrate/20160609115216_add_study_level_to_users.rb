class AddStudyLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :study_level, :string
  end
end
