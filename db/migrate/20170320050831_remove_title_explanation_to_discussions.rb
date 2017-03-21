class RemoveTitleExplanationToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :title_explanation, :text
  end
end
