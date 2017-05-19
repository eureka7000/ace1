class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :edit, :update, :destroy, :like, :discussion_room, :discussion_edit]
  before_action :authenticate_admin_user!, only: [:index, :edit, :select_leader, :give_authority]
  before_filter :authenticate_user!, only: [:past_discussions_list, :discussion_list, :discussion_room, :discussion_new, :discussion_edit]

  layout 'admin_main'

  def discussion_list_of_schools
    @schools = School.all

    processing = 0
    past = 0

    @lists = []

    @schools.each do |school|
      puts school.id
      puts school.name
      @users = User.where('school_id = ?', school.id)

      @users.each do |user|
        puts user.id
        puts user.email
        puts user.discussions.count
        processing = processing + user.discussions.where('expiration_date >= ? and start_date <= ?', Date.today, Date.today).count
        puts "#{processing}---------------------------"
        past = past + user.discussions.where('expiration_date < ?', Date.today).count
        puts "#{past}========================="
      end

      tmp = {
          id: school.id,
          name: school.name,
          processing: processing,
          past: past,
          total: processing + past,
          teacher: school.users.count
      }

      @lists << tmp

      processing = 0
      past = 0
    end

  end

  def topic_select_and_new

    unless current_user.nil?
      puts "==========================거의 관계없음"
      puts session.inspect
      puts current_user.user_name
      puts current_user
      puts current_user.inspect
      @discussion = Discussion.new
      @user_type = 'user'
      @discussion_form_id = 'new_discussion'
      @leader = Teacher.where('user_id = ?', current_user.id)
      @sub_leader = Teacher.all

      @discussion_templets = DiscussionTemplet.all
      puts "=========================="
      puts current_user.user_types[0].user_type
      puts @discussion_templets.first.user_id
      puts @discussion_templets[1].user_id
      puts "=========================="
      puts current_user.user_types.count
      puts "=========================="
      if current_user.user_types[0].user_type == 'school teacher'
        @manage_type = '학교'
        elsif current_user.user_types[0].user_type == 'institute teacher'
          @manage_type = '학원'
        elsif current_user.user_types[0].user_type == 'mento'
          @manage_type = 'EurekaMath'
      end
      puts "------------------"
      puts @manage_type

      render layout: 'application'

    else
      puts "------------------"
      @discussion = Discussion.new
      @discussion_form_id = 'new_discussion'
      @admin_id = session[:admin]['id']
      #@admin_type = session[:admin]['admin_type']
      puts @admin_id
      puts session[:admin].inspect
      puts session[:current_user].inspect
      #puts @admin_type
      @user_type = 'admin'
      @manage_type = 'EurekaMath'
      @sub_leader = Teacher.all

      @discussion_templets = DiscussionTemplet.all

      unless session[:admin]['admin_type'] != 'admin'
        puts session[:admin]['admin_type']
        # @leader = Admin.where(:admin_type => 'admin')
        @leader = Teacher.all
        puts session[:admin]['admin_type']
        else
          puts "aaaaaaa"
          if current_user.user_types[0].user_type == 'mento'
            puts "aaaaaaa111111111"
            @leader = Teacher.where('user_id = ?', current_user.id)
          else
            puts "bbbbbbb"
            @leader = Teacher.where(:school_id => session[:admin]['school_id'])
            if session[:admin]['admin_type'] == 'school manager'
              puts "cccccccc"
              @manage_type = '학교'
            else
              @manage_type = '학원'
          end
        end
      end
      puts session[:admin]['admin_type']
      @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')
      puts session[:admin]['admin_type']

      # render layout: 'admin_main'
    end

  end

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

    # 토론방 이력 저장.
    discussion_history = DiscussionHistory.where('user_id = ? and discussion_id = ?', current_user.id, @discussion.id)

    if discussion_history.count > 0
      discussion_history[0].discussion_count = discussion_history[0].discussion_count + 1
      discussion_history[0].save
    else
      discussion_history = DiscussionHistory.new
      discussion_history.user_id = current_user.id
      discussion_history.discussion_id = @discussion.id
      discussion_history.discussion_count = 1
      discussion_history.save
    end
    # 토론방 이력 저장 끝.

    render layout: 'application'
  end

#  def like
#    if @discussion.like.nil?
#      @discussion.like = 1
#    else
#      @discussion.like = @discussion.like + 1
#    end
#    @discussion.save
#    #ret = { status: "ok" }
#    ret = { 'like' => @discussion.like, status: "ok" }
#    render :json => ret
#  end

def like
    puts params[:id]
    if @discussion.like.nil?
       @discussion.like = 1
     else
       @discussion.like = @discussion.like + 1
     end
    @discussion.save
    @like = @discussion.like
    #ret = { status: "ok" }
    ret = { 'like' => @like}
    render :json => ret
  end


  def discussion_new
    @discussion = Discussion.new
    @discussion_form_id = 'new_discussion'
    @user_type = 'user'
    @leader = Teacher.where('user_id = ?', current_user.id)
    @sub_leader = Teacher.where('school_id = ?', current_user.school_id)

    if current_user.user_types[0].user_type == 'school teacher'
      @manage_type = '학교'
    elsif current_user.user_types[0].user_type == 'institute teacher'
      @manage_type = '학원'
    elsif current_user.user_types[0].user_type == 'mento'
      @manage_type = 'EurekaMath'
    end

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

    render layout: 'application'
  end

  def discussion_edit
    @discussion_form_id = 'edit_discussion_' + @discussion.id.to_s
    @user_type = 'user'
    # @checked_grade = @discussion.discussion_templet.grade.split(',')
    @manage_type = @discussion.manage_type
    @leader = Teacher.where('user_id = ?', current_user.id)
    @sub_leader = Teacher.all
    @groups = Group.where('user_id = ?', @discussion.user_id)

    render layout: 'application'
  end

  def discussion_list
    leader = params[:leader]
    unless leader.blank?
      @discussions = Discussion.where('expiration_date >= ? and start_date <= ? and user_id = ?', Date.today, Date.today, leader).order(:id => :desc)
    else
      @discussions = Discussion.where('expiration_date >= ? and start_date <= ?', Date.today, Date.today).order(:id => :desc)
    end

    @leaders = Discussion.where('expiration_date >= ?', Date.today).select(:user_id).distinct

    render layout: 'application'
  end

  def past_discussions_list
    leader = params[:leader]
    unless leader.blank?
      @discussions = Discussion.where('expiration_date <= ? and start_date <= ? and user_id = ?', Date.today, Date.today, leader).order(:created_at => :desc)
      puts "-------------------"
      else
        @discussions = Discussion.where('expiration_date < ?', Date.today).order(:created_at => :desc)
        puts "====================="
    end

    @leaders = Discussion.where('expiration_date < ?', Date.today).select(:user_id).distinct
    puts @leaders.count
    puts @leaders.select(:user_id)
    puts "lllllllll" 

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
    puts params[:key]    # c11
    # @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{key}%")
    #@concepts = Concept.where('concept_code like ?', "#{key}%").order(:concept_code)
    @concepts = Concept.where(sub_category: key).order(:concept_code)
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

  # GET /discussions
  # GET /discussions.json
  def index
    @admin_type = session[:admin]['admin_type']
    puts @admin_type
    school_id = params[:school_id]
    if @admin_type == 'admin'
      unless school_id.blank?
        @discussions = Discussion.get_org_list(school_id)
      else
        @discussions = Discussion.all
      end
    else
      @discussions = Discussion.get_org_list(session[:admin]['school_id'])
    end

  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    puts @discussion
    @unit_concept = UnitConcept.find(@discussion.discussion_templet.unit_concept_id)
    puts @unit_concept.id
    @discussion_title_explanations = DiscussionTitleExplanation.where('discussion_templet_id = ?', @discussion.discussion_templet_id)
    puts @discussion.user.user_types.first.user_type
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
    @discussion_form_id = 'new_discussion'
    @admin_id = session[:admin]['id']
    @user_type = 'admin'
    @manage_type = 'EurekaMath'
    @sub_leader = Teacher.all

    unless session[:admin]['admin_type'] != 'admin'
      # @leader = Admin.where(:admin_type => 'admin')
      @leader = Teacher.all
    else
        @leader = Teacher.where(:school_id => session[:admin]['school_id'])
        if session[:admin]['admin_type'] == 'school manager'
          @manage_type = '학교'
        elsif session[:admin]['admin_type'] == 'institute manager'
          @manage_type = '학원'
        end
    end

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

  end

  # GET /discussions/1/edit
  def edit
    @discussion_form_id = 'edit_discussion_' + @discussion.id.to_s
    puts @discussion_form_id
    puts '-------------------------------'
    @admin_id = session[:admin]['id']
    unless session[:admin]['admin_type'].nil?
      @user_type = 'admin'
    else
      @user_type = 'user'
    end
    @checked_grade = @discussion.discussion_templet.grade.split(',')
    @manage_type = @discussion.manage_type
    @sub_leader = DiscussionAuthority.all
    @groups = Group.where('user_id = ?', @discussion.user_id)

    unless session[:admin]['admin_type'] != 'admin'
      # @leader = Admin.where(:admin_type => 'admin')
      @leader = Teacher.all
    else
      @leader = Teacher.where(:school_id => session[:admin]['school_id'])
    end

    # 선택 상태 유지
    @unit_concept = UnitConcept.find(@discussion.discussion_templet.unit_concept_id)
    unit_concept_code = @unit_concept.code.slice(0, 4)
    puts "#{unit_concept_code}===================="
    concept_code = @unit_concept.code.slice(0, 3)
    puts "#{concept_code}====================="
    @unit_concepts = UnitConcept.where('exercise_yn = ? and code like ?', 'concept', "#{unit_concept_code}%")
    @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{concept_code}%")

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    discussion_image_ids = params[:discussion_image_id]

    unless params[:discussion_templet].blank?

      @discussion_templet = DiscussionTemplet.new
      @discussion_templet.code = params[:discussion_templet][:code]
      @discussion_templet.title = params[:discussion_templet][:title]
      @discussion_templet.content = params[:discussion_templet][:content]
      @discussion_templet.concept_explanation = params[:discussion_templet][:concept_explanation]
      @discussion_templet.unit_concept_id = params[:discussion_templet][:unit_concept_id]
      @discussion_templet.answer = params[:discussion_templet][:answer]
      @discussion_templet.level = params[:discussion_templet][:level]
      @discussion_templet.grade = params[:discussion_templet][:grade]
      @discussion_templet.user_id = params[:discussion_templet][:user_id]
      @discussion_templet.creator_type = params[:discussion_templet][:creator_type]
      @discussion_templet.save

      @discussion.discussion_templet_id = @discussion_templet.id
    end

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
            discussion_image.discussion_templet_id = @discussion.discussion_templet_id
            discussion_image.save
          end
        end

        unless @title_explanations.blank?
          count = 0
          (0..@title_explanations.count).each do |idx|
            logger.info "###########    #{@title_explanations[count]}, #{@title_explanation_unit_concept_ids[count]}    ############"

            unless @title_explanations[count].blank?
              @discussion_title_explanation = DiscussionTitleExplanation.new
              @discussion_title_explanation.discussion_templet_id = @discussion.discussion_templet_id
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
              @discussion_solution.discussion_templet_id = @discussion.discussion_templet_id
              @discussion_solution.save
            end
            count = count + 1
          end
        end

        if is_admin == true
          format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
          format.json { render :show, status: :created, location: @discussion }
        else
          format.html { redirect_to '/mypages/discussion_management', notice: 'Discussion was successfully created.' }
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

    unless session[:admin].nil?
      is_admin = true
    else
      is_admin = false
    end

    # 중간보고서, 최종보고서에 쓰인 이미지
    unless discussion_image_ids.blank?
      DiscussionImage.where('discussion_id = ?', @discussion.id).delete_all
      images = discussion_image_ids.to_s.split(',')
      images.each do |image|
        discussion_image = DiscussionImage.find(image)
        discussion_image.discussion_id = @discussion.id
        discussion_image.save
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

    unless session[:admin].nil?
      is_admin = true
    else
      is_admin = false
    end

    @discussion.destroy

    ret = { ret: "success" }

    respond_to do |format|
      if is_admin == true
        format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.json { render json: ret }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:organizer, :manage_type, :observer_yn, :expiration_date, :interim_report, :final_report, :organizer_type, :user_id, :start_date, :think_time, :like, :sub_leader, :group_id, :discussion_templet_id)
    end
end
