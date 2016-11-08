class AddWidthToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :width, :integer
  end
end
