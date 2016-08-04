class AddFileNameToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :file_name, :string
  end
end
