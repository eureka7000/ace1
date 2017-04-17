class DiscussionTitleExplanation < ActiveRecord::Base
  belongs_to :discussion_templet
  belongs_to :unit_concept
  has_many :discussion_title_explanation_histories
end
