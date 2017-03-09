class RemoveParitipantIdToDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :participant_id, :integer
  end
end
