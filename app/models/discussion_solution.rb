class DiscussionSolution < ActiveRecord::Base
  belongs_to :discussion_templet
  has_many :discussion_solution_history
end
