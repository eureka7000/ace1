class AddOrgToExams < ActiveRecord::Migration
  def change
    add_column :exams, :org, :string
  end
end
