class UserRelationsController < ApplicationController
  before_action :set_user_relation, only: [:show, :edit, :update, :destroy]

  # GET /user_relations/new
  def new
    @user_relation = UserRelation.new
  end

  # GET /user_relations/1/edit
  def edit
  end

    def create
        
        is_error = false
        
        unless params[:related_user_email].blank?
            
            related_user = User.find_by_email(params[:related_user_email])
            
            unless related_user.nil?
                
                is_right_person = false
                
                related_user.user_types.each do | user_type |
                    if user_type.user_type == params[:user_relation][:relation_type]
                        is_right_person = true
                    end
                end    
                
                if is_right_person
                    params[:user_relation][:related_user_id] = related_user.id                    
                else
                    is_error = true
                    flash[:alert] = "요청한 #{params[:related_user_email]} 을 사용하는 회원은 #{params[:user_relation][:relation_type]} 권한이 아닙니다."
                end        
                
            else
                is_error = true
                flash[:alert] = "요청한 #{params[:related_user_email]} 을 사용하는 회원이 존재하지 않습니다."
            end
            
        end
        
        if params[:user_relation][:user_id].blank?
            params[:user_relation][:user_id] = current_user.id
        end
        
        params[:user_relation][:confirm_status] = 'requested'
        
        unless is_error
            @user_relation = UserRelation.new(user_relation_params)
            @user_relation.save
            
            @to_user = User.find(@user_relation.related_user_id)
            
            # Mail 발송
            UserMailer.request_relation(@to_user, current_user, @user_relation).deliver_later
            
            flash[:notice] = "회원님과의 #{@user_relation.relation_type}관계를 #{@to_user.user_name}님에게 요청하였습니다."
        end        

        respond_to do |format|
            if is_error 
                format.html { redirect_to '/mypages/user_info' }
            else    
                format.html { redirect_to '/mypages/user_info'  }
            end    
        end
        
    end


  # PATCH/PUT /user_relations/1
  # PATCH/PUT /user_relations/1.json
  def update
    respond_to do |format|
      if @user_relation.update(user_relation_params)
        format.html { redirect_to @user_relation, notice: 'User relation was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_relation }
      else
        format.html { render :edit }
        format.json { render json: @user_relation.errors, status: :unprocessable_entity }
      end
    end
  end

    def destroy
        
        @user_relation.destroy
        
        ret = { ret: "success" }
        
        respond_to do |format|
            format.json { render json: ret }
        end
        
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_relation
      @user_relation = UserRelation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_relation_params
      params.require(:user_relation).permit(:user_id, :related_user_id, :relation_type, :confirm_status, :confirmed_at)
    end
end
