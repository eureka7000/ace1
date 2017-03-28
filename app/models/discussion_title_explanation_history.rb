class DiscussionTitleExplanationHistory < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion_title_explanation
end
