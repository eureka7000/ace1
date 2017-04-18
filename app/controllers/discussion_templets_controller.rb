class DiscussionTempletsController < ApplicationController
  before_action :set_discussion_templet, only: [:show, :edit, :update, :destroy, :edit_for_admin]
  before_filter :authenticate_admin_user!, only: [:list, :new_for_admin, :edit_for_admin]
  before_filter :authenticate_user!, only: [:index, :new, :edit]

  def new_for_admin
    @discussion_templet = DiscussionTemplet.new
    @admin_type = session[:admin]['admin_type']
    @admin_id = session[:admin]['id']
    @user_type = 'admin'
    @discussion_templet_form_id = 'new_discussion_templet'
    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

    render layout: 'admin_main'
  end

  def edit_for_admin
    @admin_type = session[:admin]['admin_type']
    @admin_id = session[:admin]['id']
    @user_type = 'admin'
    @discussion_templet_form_id = 'edit_discussion_templet_' + @discussion_templet.id.to_s
    @checked_grade = @discussion_templet.grade.split(',')

    @unit_concept = UnitConcept.find(@discussion_templet.unit_concept_id)
    unit_concept_code = @unit_concept.code.slice(0, 4)
    concept_code = @unit_concept.code.slice(0, 3)
    @unit_concepts = UnitConcept.where('exercise_yn = ? and code like ?', 'concept', "#{unit_concept_code}%")
    @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{concept_code}%")

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')

    render layout: 'admin_main'
  end

  def list
    @discussion_templets = DiscussionTemplet.all

    render layout: 'admin_main'
  end

  # GET /discussion_templets
  # GET /discussion_templets.json
  def index
    @discussion_templets = DiscussionTemplet.all
  end

  # GET /discussion_templets/1
  # GET /discussion_templets/1.json
  def show
    unless session[:admin].nil?
      render layout: 'admin_main'
    end
  end

  # GET /discussion_templets/new
  def new
    @discussion_templet = DiscussionTemplet.new

    @user_type = 'user'

    @discussion_templet_form_id = 'new_discussion_templet'

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')
  end

  # GET /discussion_templets/1/edit
  def edit
    @discussion_templet_form_id = 'edit_discussion_templet_' + @discussion_templet.id.to_s
    @checked_grade = @discussion_templet.grade.split(',')

    @user_type = 'user'

    @unit_concept = UnitConcept.find(@discussion_templet.unit_concept_id)
    unit_concept_code = @unit_concept.code.slice(0, 4)
    concept_code = @unit_concept.code.slice(0, 3)
    @unit_concepts = UnitConcept.where('exercise_yn = ? and code like ?', 'concept', "#{unit_concept_code}%")
    @concepts = Concept.where('exercise_yn = ? and concept_code like ?', 'concept', "#{concept_code}%")

    @related_unit_concepts = UnitConcept.where(:exercise_yn => 'concept')
  end

  # POST /discussion_templets
  # POST /discussion_templets.json
  def create
    @discussion_templet = DiscussionTemplet.new(discussion_templet_params)
    discussion_image_ids = params[:discussion_image_id]

    # nested params coding for save discussion_title_explanation
    @title_explanations = params[:title_explanation]
    @title_explanation_unit_concept_ids = params[:title_explanation_unit_concept_id]

    # nested params coding for save discussion_solution
    @solutions = params[:solution]

    respond_to do |format|
      if @discussion_templet.save

        unless discussion_image_ids.blank?
          images = discussion_image_ids.to_s.split(',')
          images.each do |image|
            discussion_image = DiscussionImage.find(image)
            discussion_image.discussion_templet_id = @discussion_templet.id
            discussion_image.save
          end
        end

        unless @title_explanations.blank?
          count = 0
          (0..@title_explanations.count).each do |idx|
            logger.info "###########    #{@title_explanations[count]}, #{@title_explanation_unit_concept_ids[count]}    ############"

            unless @title_explanations[count].blank?
              @discussion_title_explanation = DiscussionTitleExplanation.new
              @discussion_title_explanation.discussion_templet_id = @discussion_templet.id
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
              @discussion_solution.discussion_templet_id = @discussion_templet.id
              @discussion_solution.save
            end
            count = count + 1
          end
        end

        format.html { redirect_to @discussion_templet, notice: 'Discussion templet was successfully created.' }
        format.json { render :show, status: :created, location: @discussion_templet }
      else
        format.html { render :new }
        format.json { render json: @discussion_templet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussion_templets/1
  # PATCH/PUT /discussion_templets/1.json
  def update
    discussion_image_ids = params[:discussion_image_id]

    # nested params coding for save discussion_title_explanation
    @title_explanations = params[:title_explanation]
    @title_explanation_unit_concept_ids = params[:title_explanation_unit_concept_id]

    # nested params coding for save discussion_solution
    @solutions = params[:solution]

    unless discussion_image_ids.blank?
      DiscussionImage.where('discussion_templet_id = ?', @discussion_templet.id).delete_all
      images = discussion_image_ids.to_s.split(',')
      images.each do |image|
        discussion_image = DiscussionImage.find(image)
        discussion_image.discussion_id = @discussion_templet.id
        discussion_image.save
      end
    end

    unless @title_explanations.blank?
      DiscussionTitleExplanation.where('discussion_templet_id = ?', @discussion_templet.id).delete_all
      count = 0
      (0..@title_explanations.count).each do |idx|
        # logger.info "###########    #{@title_explanations[count]}, #{@title_explanation_unit_concept_ids[count]}    ############"

        unless @title_explanations[count].blank?
          @discussion_title_explanation = DiscussionTitleExplanation.new
          @discussion_title_explanation.discussion_templet_id = @discussion_templet.id
          @discussion_title_explanation.unit_concept_id = @title_explanation_unit_concept_ids[count]
          @discussion_title_explanation.content = @title_explanations[count]
          @discussion_title_explanation.save
        end
        count = count+1
      end
    end

    unless @solutions.blank?
      DiscussionSolution.where('discussion_templet_id = ?', @discussion_templet.id).delete_all

      count = 0
      (0..@solutions.count).each do |idx|
        unless @solutions[count].blank?
          logger.info "##########    #{@solutions[count]}    ##########"
          @discussion_solution = DiscussionSolution.new
          @discussion_solution.content = @solutions[count]
          @discussion_solution.discussion_templet_id = @discussion_templet.id
          @discussion_solution.save
        end
        count = count + 1
      end
    end

    respond_to do |format|
      if @discussion_templet.update(discussion_templet_params)
        format.html { redirect_to @discussion_templet, notice: 'Discussion templet was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion_templet }
      else
        format.html { render :edit }
        format.json { render json: @discussion_templet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussion_templets/1
  # DELETE /discussion_templets/1.json
  def destroy
    @discussion_templet.destroy

    ret = { ret: "success" }

    respond_to do |format|
      # format.html { redirect_to discussion_templets_url, notice: 'Discussion templet was successfully destroyed.' }
      format.json { render :json => ret }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion_templet
      @discussion_templet = DiscussionTemplet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_templet_params
      params.require(:discussion_templet).permit(:code, :title, :content, :concept_explanation, :unit_concept_id, :answer, :level, :grade, :user_id, :creator_type)
    end
end
