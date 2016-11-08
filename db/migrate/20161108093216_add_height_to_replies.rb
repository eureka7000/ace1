class AddHeightToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :height, :integer
  end
end
