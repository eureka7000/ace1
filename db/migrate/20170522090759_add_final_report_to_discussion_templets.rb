class AddFinalReportToDiscussionTemplets < ActiveRecord::Migration
  def change
    add_column :discussion_templets, :final_report, :text
  end
end
