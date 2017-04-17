class DiscussionTemplet < ActiveRecord::Base
  has_many :discussion_title_explanations, :dependent => :delete_all
  has_many :discussion_solutions, :dependent => :delete_all
  has_many :discussions

  belongs_to :unit_concept
end
