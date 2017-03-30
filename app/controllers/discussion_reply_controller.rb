class DiscussionReplyController < ApplicationController
  before_action :set_discussion_reply, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  def create
    @discussion_reply = DiscussionReply.new(discussion_reply_params)

    respond_to do |format|
      if @discussion_reply.save
        format.html { redirect_to "/discussions/discussion_room/#{@discussion_reply.discussion_id}", notice: '댓글이 성공적으로 등록되었습니다.' }
        format.json { render :show, status: :created, location: @discussion_reply }
      else
        format.html { render :new }
        format.json { render json: @discussion_reply.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_discussion_reply
    @discussion_reply = DiscussionReply.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def discussion_reply_params
    params.require(:discussion_reply).permit(:discussion_id, :user_id, :comment, :group_id, :group_no)
  end
end
