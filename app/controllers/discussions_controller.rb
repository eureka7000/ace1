class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]

  layout 'admin_main'

  def get_concept_exercise
    @concept_exercises = ConceptExercise.where(:concept_id => params[:id]).order(:desc_type, :file_name)
    ret = []
    @concept_exercises.each do |concept_exercise|
      if concept_exercise.desc_type != '4' && concept_exercise.desc_type != '5'
        ret << {
            type: concept_exercise.desc_type,
            filename: concept_exercise.file_name.to_s()
        }
      end
    end
    respond_to do |format|
      format.json { render :json => ret }
    end
  end

  def get_unit_concept_exercise
    @unit_concept_exercises = UnitConceptDesc.where(:unit_concept_id => params[:id]).order(:desc_type, :file_name)
    ret = []
    @unit_concept_exercises.each do |unit_concept_exercise|
      if unit_concept_exercise.desc_type != '4' && unit_concept_exercise.desc_type != '5'
        ret << {
            type: unit_concept_exercise.desc_type,
            filename: unit_concept_exercise.file_name.to_s()
        }
      end
    end
    respond_to do |format|
      format.json { render :json => ret }
    end
  end

  def get_concepts
    key = params[:key]
    # @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{key}%")
    @concepts = Concept.where('concept_code like ?', "#{key}%").order(:concept_code)
    ret = []
    @concepts.each do |concept|
      ret << {
          values: concept.concept_code,
          text: concept.concept_name,
          exercise_yn: concept.exercise_yn,
          grade: concept.grade,
          level: concept.level,
          code: concept.concept_code,
          id: concept.id
      }
    end

    respond_to do |format|
      format.json { render :json => ret }
    end
  end

  def get_unit_concepts
    key = params[:key]
    @unit_concepts = UnitConcept.where('code like ?', "#{key}%")

    ret = []
    @unit_concepts.each do |unit_concept|
      ret << {
          values: unit_concept.id,
          text: unit_concept.name,
          exercise_yn: unit_concept.exercise_yn,
          grade: unit_concept.grade,
          level: unit_concept.level,
          code: unit_concept.code
      }
    end

    respond_to do |format|
      format.json { render :json => ret }
    end
  end

  def select_leader
    @school_teachers = UserType.where(:user_type => 'school teacher')
    @institute_teachers = UserType.where(:user_type => 'institute teacher')
    @mentos = UserType.where(:user_type => 'mento')
  end

  # select_leader 에서 multi_select 으로 인한 staff 생성
  def create_staff
    user_types = params[:user_types]
    # month = params[:month].to_i

    @tmp_staff = Staff.where(:admin_id => session[:admin]['id'])
    @tmp_staff.delete_all

    unless user_types.nil?
      user_types.each do |user_type|
        u_type = UserType.find(user_type)
        staff = Staff.new
        staff.user_id = u_type.user_id
        staff.user_type_id = u_type.id
        staff.admin_id = session[:admin]['id']
        staff.save
      end
    end

    respond_to do |format|
      format.html { redirect_to '/discussions/select_leader' }
    end
  end

  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @leader = User.find(@discussion.leader)
    @unit_concept = UnitConcept.find(@discussion.unit_concept_id)
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
    @discussion_form_id = 'new_discussion'
    @admin_id = session[:admin]['id']
    @admin_type = session[:admin]['admin_type']

    unless session[:admin]['admin_type'] != 'admin'
      # @leader = Admin.where(:admin_type => 'admin')
      @leader = Staff.where(:admin_id => session[:admin]['id'])
      @manage_type = 'EurekaMath'
    else
      @leader = Teacher.where(:school_id => session[:admin]['school_id'])
      if session[:admin]['admin_type'] == 'school manager'
        @manage_type = '학교'
      else
        @manage_type = '학원'
      end
    end

    # 공통필요부분
    # @concepts = Concept.where(:exercise_yn => 'concept').order(:concept_code)
    # @unit_concepts = UnitConcept.where(:exercise_yn => 'concept').order(:code)

  end

  # GET /discussions/1/edit
  def edit
    @discussion_form_id = 'edit_discussion_' + @discussion.id.to_s
    @admin_id = session[:admin]['id']
    @admin_type = session[:admin]['admin_type']
    @checked_grade = @discussion.grade.split(',')

    unless session[:admin]['admin_type'] != 'admin'
      # @leader = Admin.where(:admin_type => 'admin')
      @leader = Staff.where(:admin_id => session[:admin]['id'])
      @manage_type = 'EurekaMath'
    else
      @leader = Teacher.where(:school_id => session[:admin]['school_id'])
      if session[:admin]['admin_type'] == 'school manager'
        @manage_type = '학교'
      else
        @manage_type = '학원'
      end
    end

    # 선택 상태 유지
    @unit_concept = UnitConcept.find(@discussion.unit_concept_id)
    unit_concept_code = @unit_concept.code.slice(0, 4)
    concept_code = @unit_concept.code.slice(0, 3)
    @unit_concepts = UnitConcept.where('exercise_yn = ? and code like ?', 'concept', "#{unit_concept_code}%")
    @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{concept_code}%")
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    discussion_image_ids = params[:discussion_image_id]

    respond_to do |format|
      if @discussion.save
        unless discussion_image_ids.blank?
          images = discussion_image_ids.to_s.split(',')
          images.each do |image|
            discussion_image = DiscussionImage.find(image)
            discussion_image.discussion_id = @discussion.id
            discussion_image.save
          end
        end

        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:organizer, :leader, :manage_type, :observer_yn, :title, :content, :unit_concept_id, :title_explanation, :answer, :grade, :expiration_date, :interim_report, :final_report, :solution)
    end
end
