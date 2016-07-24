class AddConfirmStatusToUserRelations < ActiveRecord::Migration
  def change
      add_column :user_relations, :confirm_status, :string
      add_column :user_relations, :request_date, :datetime, :default => DateTime.now
      add_column :user_relations, :confirmed_at, :datetime
  end
end
