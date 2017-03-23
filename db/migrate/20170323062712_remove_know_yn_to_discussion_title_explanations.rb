class RemoveKnowYnToDiscussionTitleExplanations < ActiveRecord::Migration
  def change
    remove_column :discussion_title_explanations, :know_yn, :string
  end
end
