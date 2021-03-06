class RepliesController < ApplicationController
    
    before_action :set_reply, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_user!, only: [:create, :update, :destroy]

    def create
        
        @reply = Reply.new(reply_params)
        @reply.user_id = current_user.id

        # 어느 누구든 답변을 해주었을 때
        @question = Question.find(@reply.question_id)
        @question.confirm_yn = 'Y'
        if @question.save
            mentee = User.find(@question.user_id)

            # Mail 발송
            UserMailer.noti_reply(mentee, current_user, @question).deliver_later
        end

        # 지정한 선생님에게 질문을 요청했고, 그 선생님이 답변을 해주었을 때
        # if @reply.question.to_user_id == current_user.id
        #     @question = Question.find(@reply.question_id)
        #     @question.confirm_yn = 'Y'
        #
        #     if @question.save
        #         mentee = User.find(@question.user_id)
        #
        #         # Mail 발송
        #         UserMailer.noti_reply(mentee, current_user, @question).deliver_later
        #     end
        # end

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
    params.require(:reply).permit(:question_id, :comment, :group_id, :parent_reply_id, :depth, :order_no, :file_name)
  end

end
