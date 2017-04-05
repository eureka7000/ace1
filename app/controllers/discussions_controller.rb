class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :edit, :update, :destroy, :like, :discussion_room, :discussion_edit]
  before_action :authenticate_admin_user!, only: [:index, :edit, :destroy, :select_leader, :give_authority]
  before_filter :authenticate_user!, only: [:discussion_list, :discussion_room, :discussion_new, :discussion_edit]

  layout 'admin_main'

  def save_discussion_solution_history
    solution_yn = params[:solution_yn]
    solution_id = params[:solution_id]

    @discussion_solution_history = DiscussionSolutionHistory.new

    @discussion_solution_history.user_id = current_user.id
    @discussion_solution_history.discussion_solution_id = solution_id
    @discussion_solution_history.know_yn = solution_yn

    if @discussion_solution_history.save
      ret = { status: "ok" }
      respond_to do |format|
        format.json { render :json => ret }
      end
    end
  end

  def save_title_explanation_history
    title_explanation_yn = params[:title_explanation_yn]
    title_explanation_id = params[:title_explanation_id]

    @discussion_title_explanation_history = DiscussionTitleExplanationHistory.new

    @discussion_title_explanation_history.user_id = current_user.id
    @discussion_title_explanation_history.discussion_title_explanation_id = title_explanation_id
    @discussion_title_explanation_history.know_yn = title_explanation_yn

    if @discussion_title_explanation_history.save
      ret = { status: "ok" }
      respond_to do |format|
        format.json { render :json => ret }
      end
    end
  end

  def discussion_room
    @discussion_replies = DiscussionReply.where('discussion_id = ? and group_id = ?', @discussion.id, 0)

    @participant = Participant.where('discussion_id = ? and user_id = ?', @discussion.id, current_user.id)

    @participant_before_check = true

    if @participant.blank?
      @participant = Participant.new
      @participant.discussion_id = @discussion.id
      @participant.user_id = current_user.id

      if @participant.save
        @participant_before_check = false
      end
    end

    render layout: 'application'
  end

  def like
    if @discussion.like.nil?
      @discussion.like = 1
    else
      @discussion.like = @discussion.like + 1
    end
    @discussion.save
    ret = { status: "ok" }
    render :json => ret
  end

  def discussion_new
    @discussion = Discussion.new
    @discussion_form_id = 'new_discussion'
    @leader = Teacher.where('user_id = ?', current_user.id)
    @user_type = 'user'

    if current_user.user_types[0].user_type == 'school teacher'
      @manage_type = '학교'
    elsif current_user.user_types[0].user_type == 'institute teacher'
      @manage_type = '학원'
    end

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

    render layout: 'application'
  end

  def discussion_edit
    @discussion_form_id = 'edit_discussion_' + @discussion.id.to_s
    @user_type = 'user'
    @checked_grade = @discussion.grade.split(',')
    @manage_type = @discussion.manage_type
    @leader = Teacher.where('user_id = ?', current_user.id)

    # 선택 상태 유지
    @unit_concept = UnitConcept.find(@discussion.unit_concept_id)
    unit_concept_code = @unit_concept.code.slice(0, 4)
    concept_code = @unit_concept.code.slice(0, 3)
    @unit_concepts = UnitConcept.where('exercise_yn = ? and code like ?', 'concept', "#{unit_concept_code}%")
    @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{concept_code}%")

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

    render layout: 'application'
  end

  def discussion_list
    @discussions = Discussion.all.order(:created_at => :desc)

    render layout: 'application'
  end

  def give_authority
    @admin_type = session[:admin]['admin_type']

    if @admin_type == 'admin'
      @school_teachers = UserType.where(:user_type => 'school teacher')
      @institute_teachers = UserType.where(:user_type => 'institute teacher')
      @mentos = UserType.where(:user_type => 'mento')
    end

    if @admin_type == 'institute manager'
      @institute_teachers = UserType.get_my_authority_member(session[:admin]['school_id'])
    end

    if @admin_type == 'school manager'
      @school_teachers = UserType.get_my_authority_member(session[:admin]['school_id'])
    end
  end

  # give_authority 에서 multi_select 으로 인한 discussion_authority 생성
  def create_give_authority
    user_types = params[:user_types]
    # month = params[:month].to_i

    @tmp_authority = DiscussionAuthority.where(:admin_id => session[:admin]['id'])
    @tmp_authority.delete_all

    unless user_types.nil?
      user_types.each do |user_type|
        u_type = UserType.find(user_type)
        authority = DiscussionAuthority.new
        authority.user_id = u_type.user_id
        authority.admin_id = session[:admin]['id']
        authority.save
      end
    end

    respond_to do |format|
      format.html { redirect_to '/discussions/give_authority' }
    end
  end

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
    @admin_type = session[:admin]['admin_type']

    if @admin_type == 'admin'
      @discussions = Discussion.all
    elsif @admin_type == 'school manager' || @admin_type == 'institute manager'
      @discussions = Discussion.get_org_list(session[:admin]['school_id'])
    end

  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @unit_concept = UnitConcept.find(@discussion.unit_concept_id)
    @discussion_title_explanations = DiscussionTitleExplanation.where('discussion_id = ?', @discussion.id)
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
    @discussion_form_id = 'new_discussion'
    @admin_id = session[:admin]['id']
    @user_type = 'admin'

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

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

  end

  # GET /discussions/1/edit
  def edit
    @discussion_form_id = 'edit_discussion_' + @discussion.id.to_s
    @admin_id = session[:admin]['id']
    unless session[:admin]['admin_type'].nil?
      @user_type = 'admin'
    else
      @user_type = 'user'
    end
    @checked_grade = @discussion.grade.split(',')
    @manage_type = @discussion.manage_type

    unless session[:admin]['admin_type'] != 'admin'
      # @leader = Admin.where(:admin_type => 'admin')
      @leader = Staff.where(:admin_id => session[:admin]['id'])
    else
      @leader = Teacher.where(:school_id => session[:admin]['school_id'])
    end

    # 선택 상태 유지
    @unit_concept = UnitConcept.find(@discussion.unit_concept_id)
    unit_concept_code = @unit_concept.code.slice(0, 4)
    concept_code = @unit_concept.code.slice(0, 3)
    @unit_concepts = UnitConcept.where('exercise_yn = ? and code like ?', 'concept', "#{unit_concept_code}%")
    @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{concept_code}%")

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    discussion_image_ids = params[:discussion_image_id]

    # nested params coding for save discussion_title_explanation
    @title_explanations = params[:title_explanation]
    @title_explanation_unit_concept_ids = params[:title_explanation_unit_concept_id]

    # nested params coding for save discussion_solution
    @solutions = params[:solution]

    unless session[:admin].nil?
      is_admin = true
    else
      is_admin = false
    end

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

        unless @title_explanations.blank?
          count = 0
          (0..@title_explanations.count).each do |idx|
            logger.info "###########    #{@title_explanations[count]}, #{@title_explanation_unit_concept_ids[count]}    ############"

            unless @title_explanations[count].blank?
              @discussion_title_explanation = DiscussionTitleExplanation.new
              @discussion_title_explanation.discussion_id = @discussion.id
              @discussion_title_explanation.unit_concept_id = @title_explanation_unit_concept_ids[count]
              @discussion_title_explanation.content = @title_explanations[count]
              @discussion_title_explanation.save
            end
            count = count+1
          end
        end

        unless @solutions.blank?
          count = 0
          (0..@solutions.count).each do |idx|
            unless @solutions[count].blank?
              @discussion_solution = DiscussionSolution.new
              @discussion_solution.content = @solutions[count]
              @discussion_solution.discussion_id = @discussion.id
              @discussion_solution.save
            end
            count = count + 1
          end
        end



        if is_admin == true
          format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
          format.json { render :show, status: :created, location: @discussion }
        else
          format.html { redirect_to '/discussions/discussion_list', notice: 'Discussion was successfully created.' }
        end

      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    discussion_image_ids = params[:discussion_image_id]

    # nested params coding for save discussion_title_explanation
    @title_explanations = params[:title_explanation]
    @title_explanation_unit_concept_ids = params[:title_explanation_unit_concept_id]

    # nested params coding for save discussion_solution
    @solutions = params[:solution]

    unless session[:admin].nil?
      is_admin = true
    else
      is_admin = false
    end

    unless discussion_image_ids.blank?
      DiscussionImage.where('discussion_id = ?', @discussion.id).delete_all
      images = discussion_image_ids.to_s.split(',')
      images.each do |image|
        discussion_image = DiscussionImage.find(image)
        discussion_image.discussion_id = @discussion.id
        discussion_image.save
      end
    end

    unless @title_explanations.blank?
      DiscussionTitleExplanation.where('discussion_id = ?', @discussion.id).delete_all
      count = 0
      (0..@title_explanations.count).each do |idx|
        # logger.info "###########    #{@title_explanations[count]}, #{@title_explanation_unit_concept_ids[count]}    ############"

        unless @title_explanations[count].blank?
          @discussion_title_explanation = DiscussionTitleExplanation.new
          @discussion_title_explanation.discussion_id = @discussion.id
          @discussion_title_explanation.unit_concept_id = @title_explanation_unit_concept_ids[count]
          @discussion_title_explanation.content = @title_explanations[count]
          @discussion_title_explanation.save
        end
        count = count+1
      end
    end

    unless @solutions.blank?
      DiscussionSolution.where('discussion_id = ?', @discussion.id).delete_all

      count = 0
      (0..@solutions.count).each do |idx|
        unless @solutions[count].blank?
          logger.info "##########    #{@solutions[count]}    ##########"
          @discussion_solution = DiscussionSolution.new
          @discussion_solution.content = @solutions[count]
          @discussion_solution.discussion_id = @discussion.id
          @discussion_solution.save
        end
        count = count + 1
      end
    end


    respond_to do |format|
      if @discussion.update(discussion_params)

        if is_admin == true
          format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
          format.json { render :show, status: :ok, location: @discussion }
        else
          format.html { redirect_to '/mypages/discussion_management', notice: 'Discussion was successfully updated.' }
        end
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
      params.require(:discussion).permit(:organizer, :manage_type, :observer_yn, :title, :content, :unit_concept_id, :answer, :grade, :expiration_date, :interim_report, :final_report, :concept_explanation, :level, :organizer_type, :user_id, :start_date, :think_time, :like)
    end
end
