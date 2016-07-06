class ConceptsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_concept, only: [:show, :edit, :update, :destroy, :exercise]
    layout '/layouts/admin_main'

    def get_concepts
       
        concepts = Concept.where('category = ? and sub_category = ?',params[:category], params[:sub_category])
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

    # GET /concepts/1
    # GET /concepts/1.json
    def show
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
        
    end    
          

    def create
      
        @concept = Concept.new(concept_params)

        respond_to do |format|
            if @concept.save
                format.html { redirect_to concepts_path, notice: 'Concept was successfully created.' }
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
                format.html { redirect_to concepts_path, notice: 'Concept was successfully updated.' }
                format.json { render :show, status: :ok, location: @concept }
            else
                format.html { render :edit }
                format.json { render json: @concept.errors, status: :unprocessable_entity }
            end
        end
        
    end

  # DELETE /concepts/1
  # DELETE /concepts/1.json
  def destroy
    @concept.destroy
    respond_to do |format|
      format.html { redirect_to concepts_url, notice: 'Concept was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concept
      @concept = Concept.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concept_params
      params.require(:concept).permit(:category, :sub_category, :concept_code, :concept_name, :exercise_yn)
    end
end
