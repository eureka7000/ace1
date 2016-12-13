class AddPastTestNumberToConcepts < ActiveRecord::Migration
  def change
    add_column :concepts, :past_test_number, :string
  end
end
