class AddOrganizerTypeToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :organizer_type, :string
  end
end
