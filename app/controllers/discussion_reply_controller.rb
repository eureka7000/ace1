class DiscussionReplyController < ApplicationController
  before_action :set_discussion_reply, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  def get_discussion_reply_comment
    discussion_reply_id = params[:discussion_reply_id]
    @discussion_replys = DiscussionReply.where(:id => discussion_reply_id)

    unless @discussion_replys.blank?
      ret = []
      @discussion_replys.each do |discussion_reply|
        ret << {
            id: discussion_reply.id,
            comment: discussion_reply.comment
        }
      end
    end

    puts ret.inspect

    respond_to do |format|
      format.json { render :json => ret }
    end
  end

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
    @status = 'update'

    respond_to do |format|
      if @discussion_reply.update(discussion_reply_params)
        format.html { redirect_to "/discussions/discussion_room/#{@discussion_reply.discussion_id}", notice: '댓글이 성공적으로 수정되었습니다.' }
        format.json { render :show, status: :ok, location: @discussion_reply }
      else
        format.html { render :edit }
        format.json { render json: @discussion_reply.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @discussion_reply.destroy
    respond_to do |format|
      format.html { redirect_to "/discussions/discussion_room/#{@discussion_reply.discussion_id}", notice: 'Discussion_reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_discussion_reply
    @discussion_reply = DiscussionReply.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def discussion_reply_params
    params.require(:discussion_reply).permit(:discussion_id, :user_id, :comment, :group_id, :group_no, :depth)
  end
end
