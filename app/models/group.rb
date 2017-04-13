class Group < ActiveRecord::Base
  belongs_to :discussion
  has_and_belongs_to_many :users

  def self.is_selected_in_group?(user_id)
    @groups_users = GroupsUser.where('group_id = ? and user_id = ?', group_id, user_id)
    unless @groups_users.blank?
      return true
    else
      return false
    end
  end
end
