class AddStartDateToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :start_date, :date
  end
end
