class TeachersController < ApplicationController
      
      before_action :authenticate_admin_user!, only: [:index, :show, :edit, :update, :destroy, :main]
      before_action :authenticate_user!, only: [:create]
      before_action :set_teacher, only: [:show, :edit, :update, :destroy]
      
      layout '/layouts/admin_main'

      # GET /teachers
      # GET /teachers.json
      def index

          @teachers = Teacher.where('school_id = ?',session[:admin]['school_id'])
          
      end

      def students_list
        schoolID = session[:admin]['school_id']

        @students = User.where('school_id = ?', schoolID).order(:user_name).paginate( :page => params[:page].blank? ? 1 : params[:page], :per_page => 20 )

      end

      # GET /teachers/1
      # GET /teachers/1.json
      def show
          
          teacher = Teacher.find(params[:id])
          teacher.confirm_yn = params[:confirm]
          teacher.confirmed_at = DateTime.now
          teacher.confirmed_id = session[:admin]['id']
          
          if teacher.save
              redirect_to '/teachers'      
          end
          
      end

      # GET /teachers/new
      # def new
      #     @teacher = Teacher.new
      # end

      # GET /teachers/1/edit
      # def edit
      # end

      # POST /teachers
      # POST /teachers.json
      def create
          
          ret = {}
        
          if params[:school_id].blank?
              ret = { :error => '학교가 선택되지 않았습니다.'}
          end
        
          if params[:manager_email].blank?
              ret = { :error => '관리자 전자우편이 비어있습니다.'}
          end    
                
          school_manager = Admin.where('school_id = ? and email = ?', params[:school_id], params[:manager_email])
          
          if school_manager.blank?
              logger.error "There is not school manager."
              ret = { :error => '해당 정보로 학교(학원)관리자를 찾을 수 없습니다.' }
          else
              
              teacher = current_user.teachers.first
              unless teacher.blank?
                  if teacher.confirm_yn.nil?
                      ret = { :error => '학교 관리자가 아직 확인을 하지 않으셨습니다. 확인을 할 때까지 기다려 주세요.'}                      
                  end
                  
                  if teacher.confirm_yn == 'N'
                      ret = { :error => '학교 관리자가 귀하를 학교 선생님으로 동의하지 않으셨습니다. 학교 담당자에게 직접 문의하세요.'}                                         
                  end
              else      
                  
                  UserMailer.cert_teacher(school_manager.first, current_user).deliver
              
                  @teacher = Teacher.new
                  @teacher.user_id = params[:user_id]
                  @teacher.school_id = params[:school_id]
                  @teacher.save
              
                  ret = { :result => 'success' }                  
                  
              end      
              
          end     

          respond_to do |format|
              format.json { render :json => ret }
          end    

      end

      # PATCH/PUT /teachers/1
      # PATCH/PUT /teachers/1.json
      # def update
      #     respond_to do |format|
      #         if @teacher.update(teacher_params)
      #             format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
      #             format.json { render :show, status: :ok, location: @teacher }
      #         else
      #             format.html { render :edit }
      #             format.json { render json: @teacher.errors, status: :unprocessable_entity }
      #         end
      #     end
      # end

      # DELETE /teachers/1
      # DELETE /teachers/1.json
      # def destroy
      #     @teacher.destroy
      #
      #     respond_to do |format|
      #         format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
      #         format.json { head :no_content }
      #     end
      # end

      private
      # Use callbacks to share common setup or constraints between actions.

      def set_teacher
          @teacher = Teacher.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def teacher_params
          params.require(:teacher).permit(:user_id, :school_id, :confirm_yn, :confirmed_at, :comfirmed_id)
      end
      
end
