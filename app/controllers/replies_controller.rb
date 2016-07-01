class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  def index
  end

  def create
    @reply = Reply.new(reply_params)

    respond_to do |format|
      if @reply.save
        format.html { redirect_to "/questions/#{params[:reply][:question_id]}", notice: '댓글이 성공적으로 등록되었습니다.' }
      end
    end
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
    id = @reply.question_id
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to "/questions/#{id}", notice: 'reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_reply
    @reply = Reply.find(params[:id])
  end
  def reply_params
    params.require(:reply).permit(:question_id, :user_id, :comment, :group_id, :parent_reply_id, :depth, :order_no)
  end

end
