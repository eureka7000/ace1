class DiscussionSolution < ActiveRecord::Base
  belongs_to :discussion
  has_many :discussion_solution_history
end
