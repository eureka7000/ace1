class DiscussionSolutionHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion_solution
end
