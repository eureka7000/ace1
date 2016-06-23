class ChangeJoinChannelToInteger < ActiveRecord::Migration
  def change
      remove_column :users, :join_channel
      add_column :users, :join_channel, :integer
  end
end
