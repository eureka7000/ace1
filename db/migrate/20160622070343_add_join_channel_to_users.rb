class AddJoinChannelToUsers < ActiveRecord::Migration
    
    def change
        add_column :users, :join_channel, :string
        add_column :users, :join_channel_sales_id, :integer
    end
    
end
