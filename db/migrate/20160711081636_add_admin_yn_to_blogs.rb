class AddAdminYnToBlogs < ActiveRecord::Migration
  def change
      add_column :blogs, :admin_yn, :string
  end
end
