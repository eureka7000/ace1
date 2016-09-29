class AddPastTestYearToConcepts < ActiveRecord::Migration
  def change
      add_column :concepts, :past_test_year, :string
      add_column :concepts, :past_test_month, :string
      add_column :concepts, :past_test_type, :string
      add_column :concepts, :past_test_org, :string
  end
end
