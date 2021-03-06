class ConceptsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_concept, only: [:edit, :update, :destroy, :exercise]
    layout '/layouts/admin_main'

    def get_concepts
       
        concepts = Concept.where('category = ? and sub_category = ? and exercise_yn = ?',params[:category], params[:sub_category], 'concept')
        render :json => concepts
        
    end    
    
    def get_unit_concepts
       
        unit_concepts = UnitConcept.where('concept_id = ? and exercise_yn = ?', params[:concept], "concept")
        render :json => unit_concepts
        
    end    

    # GET /concepts
    # GET /concepts.json
    def index
        
        category = params[:category]
        sub_category = params[:sub_category]
        exercise_yn = params[:exercise_yn]
        page = params[:page].blank? ? 1 : params[:page]
        
        if category.nil? && sub_category.nil? && exercise_yn.nil?
            @concepts = Concept.all.paginate( :page => page, :per_page => 30 ).order(:category, :sub_category, :concept_code)
        else
            
            str = "";
                        
            unless category.blank?
                str += " category = '#{category}' "
            end
            
            unless sub_category.blank?
                if str == ""
                    str += " sub_category = '#{sub_category}' "
                else
                    str += " and sub_category = '#{sub_category}' "
                end        
            end
            
            unless exercise_yn.blank?
                if str == ""
                    str += " exercise_yn = '#{exercise_yn}' "
                else
                    str += " and exercise_yn = '#{exercise_yn}' "
                end        
            end    
                
            @concepts = Concept.where(str).paginate( :page => params[:page], :per_page => 30 ).order(:category, :sub_category, :concept_code)
            
        end        
        
        @categorys = Concept.group('category')
        
    end

    def show
        @concept = Concept.where('id = ?',params[:id]).first
        @unit_concepts = UnitConcept.where('concept_id=?',params[:id]).order(:code)
        @exercises = UnitConcept.where('concept_id=? and exercise_yn = ?', params[:id], 'exercise').order(:code)
    end

  # GET /concepts/new
  def new
    @concept = Concept.new
  end

  # GET /concepts/1/edit
  def edit
  end
  
    def exercise
        @unit_concept = @concept
        @desc_type = params[:desc_type]
        
        if @desc_type.blank? || @desc_type == 'i'
            @concept_exercises = @concept.concept_exercises.order(:desc_type, :memo)
        else
            @concept_exercises = @concept.concept_exercises.where('desc_type = ?',@desc_type).order(:desc_type, :memo)
        end        
        @origin = "concept exercise"
    end    
          

    def create
      
        @concept = Concept.new(concept_params)

        respond_to do |format|
            if @concept.save
                format.html { redirect_to concepts_path + "?category=#{params[:concept][:category]}&sub_category=#{params[:concept][:sub_category]}&exercise_yn=#{params[:concept][:exercise_yn]}", notice: 'Concept was successfully created.' }
                format.json { render :show, status: :created, location: @concept }
            else
                format.html { render :new }
                format.json { render json: @concept.errors, status: :unprocessable_entity }
            end
        end
      
    end
    
  
    def update
        
        respond_to do |format|
            if @concept.update(concept_params)
                format.html { redirect_to concepts_path + "?category=#{params[:category]}&sub_category=#{params[:sub_category]}&exercise_yn=#{params[:exercise_yn]}&page=#{params[:page]}" , notice: 'Concept was successfully updated.' }
                format.json { render :show, status: :ok, location: @concept }
            else
                format.html { render :edit }
                format.json { render json: @concept.errors, status: :unprocessable_entity }
            end
        end
        
    end

    
    def destroy
        @concept_exercises = ConceptExercise.where('concept_id = ? and desc_type = ?', @concept.id, '3')
        @concept_exercises.each do |concept_exercise|
            @concept_exercise_solution_links = ConceptExerciseSolutionLink.where('concept_exercise_id = ?', concept_exercise.id)
            unless @concept_exercise_solution_links.nil?
                @concept_exercise_solution_links.each do |concept_exercise_solution_link|
                    concept_exercise_solution_link.destroy
                end
            end
        end

        @concept.destroy
        respond_to do |format|
            format.html { redirect_to "/concepts?#{params.to_query}", notice: 'Concept was successfully destroyed.' }
            format.json { head :no_content }
        end
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concept
      @concept = Concept.find(params[:id])
    end


    def concept_params
        params.require(:concept).permit(:category, :sub_category, :concept_code, :concept_name, :exercise_yn, :grade, :level, :past_test_year, :past_test_month, :past_test_type, :past_test_org, :past_test_score, :past_test_number, :past_test_examiner)
    end
    
end
