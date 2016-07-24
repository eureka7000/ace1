class UserTypesController < ApplicationController
    
    before_action :set_user_type, only: [:show, :edit, :update, :destroy]

    def create
        
        @user_type = UserType.new(user_type_params)
        @user_type.save
            
        flash[:notice] = "회원님의 회원타입의 승인을 관리자에게 요청하였습니다."

        respond_to do |format|
            format.html { redirect_to '/mypages/user_info' }
        end
        
    end

    #---------------------------------------------
    private
    
    def set_user_type
        @user_type = UserType.find(params[:id])
    end

    def user_type_params
        params.require(:user_type).permit(:user_id, :user_type)
    end
    
end
