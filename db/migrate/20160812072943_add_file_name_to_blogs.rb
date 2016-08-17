class AddFileNameToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :file_name, :string
  end
end
