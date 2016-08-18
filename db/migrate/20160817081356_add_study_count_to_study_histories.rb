class AddStudyCountToStudyHistories < ActiveRecord::Migration
  def change
      add_column :study_histories, :study_count, :integer, :default => 1
  end
end
