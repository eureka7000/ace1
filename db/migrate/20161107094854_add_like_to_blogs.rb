class AddLikeToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :like, :integer
  end
end
