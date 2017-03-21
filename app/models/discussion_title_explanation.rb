class DiscussionTitleExplanation < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :unit_concept
end
