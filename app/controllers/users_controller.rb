class UsersController < ApplicationController

    before_filter :authenticate_user!

    def welcome

        respond_to do |format|
            format.html
        end

    end
    
    # PUT /users/1
    # PUT /users/1.json
    def update
        
        @user = User.find(params[:id])
        @user.user_name = params[:user][:user_name]
        @user.location = params[:user][:location]
        @user.phone = params[:user][:phone]
        

        respond_to do |format|
            if @user.save
                format.html { redirect_to '/mypages/settings?active_tab=2' }
                format.json { head :no_content }
            else
                format.html { redirect_to '/mypages/settings?active_tab=2' }
                format.json { render json: @account_item.errors, status: :unprocessable_entity }
            end
        end
        
    end


end