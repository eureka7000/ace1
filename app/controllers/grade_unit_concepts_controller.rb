class GradeUnitConceptsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_grade_unit_concept, only: [:show, :edit, :update, :destroy]
    layout '/layouts/admin_main'
    
    def get_chapters
        
        grade = params[:grade]
        err = false
        ret = {
            chapters: []
        }
        
        if grade.blank?
            err = true
        else
            GradeUnitConcept::CHAPTERS.each_pair do |key, value|
                if grade == key.to_s[0]
                    ret[:chapters] << { key: key, value: value }
                end    
            end    
        end
        
        respond_to do |format|
            if err
                format.json { render json: ret, status: :grade_is_blank }
            else
                format.json { render json: ret }
            end        
        end    
        
    end    
    
    def get_categories
        
        chapter = params[:chapter]
        err = false
        ret = {
            categoies: []
        }
        
        if chapter.blank?
            err = true
        else
            GradeUnitConcept::CATEGROIES.each_pair do |key, value|
                if chapter == key.to_s[0..2]
                    ret[:categoies] << { key: key, value: value }
                end    
            end    
        end
        
        respond_to do |format|
            if err
                format.json { render json: ret, status: :chapter_is_blank }
            else
                format.json { render json: ret }
            end        
        end    
        
    end    
    
    def get_sub_categories
        
        category = params[:category]
        err = false
        ret = {
            sub_categoies: []
        }
        
        if category.blank?
            err = true
        else
            GradeUnitConcept::SUB_CATEGROIES.each_pair do |key, value|
                if category == key.to_s[0..4]
                    ret[:sub_categoies] << { key: key, value: value }
                end
            end
        end
        
        respond_to do |format|
            if err
                format.json { render json: ret, status: :category_is_blank }
            else
                format.json { render json: ret }
            end        
        end    
        
    end 
    
    def get_unit_concepts
        
        unit_concept_code = params[:unit_concept_code]
        err = false
        ret = {
            unit_concepts: []
        }
        
        if unit_concept_code.blank?
            err = true
        else
            
            unit_concepts = UnitConcept.where("code like ?", unit_concept_code + '%')
            
            unit_concepts.each do |rs|
                ret[:unit_concepts] << { id: rs.id, name: rs.name, code: rs.code }
            end
        end
        
        respond_to do |format|
            if err
                format.json { render json: ret, status: :unit_concept_code_is_blank }
            else
                format.json { render json: ret }
            end        
        end          
        
    end    
        

    # GET /grade_unit_concepts
    # GET /grade_unit_concepts.json
    def index
        @grade_unit_concepts = GradeUnitConcept.all.paginate( :page => params[:page], :per_page => 30 ).order(:chapter, :category, :sub_category, :code)
    end

    # GET /grade_unit_concepts/new
    def new
        @grade_unit_concept = GradeUnitConcept.new
        @chapters = []
        @categories = []
        @sub_categories = []
        
        unless params[:grade_unit_concept_id].blank?
            
            before_grade_unit_concept = GradeUnitConcept.find(params[:grade_unit_concept_id])
            
            @grade_unit_concept.grade = before_grade_unit_concept.grade
            @grade_unit_concept.chapter = before_grade_unit_concept.chapter
            @grade_unit_concept.category = before_grade_unit_concept.category
            @grade_unit_concept.sub_category = before_grade_unit_concept.sub_category
            
            GradeUnitConcept::CHAPTERS.each_pair do |key, value|
                if before_grade_unit_concept.grade == key.to_s[0]
                    @chapters << { key: key, value: value }
                end    
            end  
        
            GradeUnitConcept::CATEGROIES.each_pair do |key, value|
                if before_grade_unit_concept.chapter == key.to_s[0..2]
                    @categories << { key: key, value: value }
                end    
            end    
        
            GradeUnitConcept::SUB_CATEGROIES.each_pair do |key, value|
                if before_grade_unit_concept.category == key.to_s[0..4]
                    @sub_categories << { key: key, value: value }
                end
            end              
            
        end    
        

        
    end

    # GET /grade_unit_concepts/1/edit
    def edit
        
        @chapters = [] 
        @categories = []    
        @sub_categories = []       
        
        GradeUnitConcept::CHAPTERS.each_pair do |key, value|
            if @grade_unit_concept.grade == key.to_s[0]
                @chapters << { key: key, value: value }
            end    
        end  
        
        GradeUnitConcept::CATEGROIES.each_pair do |key, value|
            if @grade_unit_concept.chapter == key.to_s[0..2]
                @categories << { key: key, value: value }
            end    
        end    
        
        GradeUnitConcept::SUB_CATEGROIES.each_pair do |key, value|
            if @grade_unit_concept.category == key.to_s[0..4]
                @sub_categories << { key: key, value: value }
            end
        end        
        
    end

    # POST /grade_unit_concepts
    # POST /grade_unit_concepts.json
    def create
        
        @grade_unit_concept = GradeUnitConcept.new(grade_unit_concept_params)

        respond_to do |format|
            if @grade_unit_concept.save
                format.html { redirect_to "/grade_unit_concepts/new?grade_unit_concept_id=#{@grade_unit_concept.id}", notice: 'Grade unit concept was successfully created.' }
                format.json { render :show, status: :created, location: @grade_unit_concept }
            else
                format.html { render :new }
                format.json { render json: @grade_unit_concept.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /grade_unit_concepts/1
    # PATCH/PUT /grade_unit_concepts/1.json
    def update
        respond_to do |format|
            if @grade_unit_concept.update(grade_unit_concept_params)
                format.html { redirect_to grade_unit_concepts_url, notice: 'Grade unit concept was successfully updated.' }
                format.json { render :show, status: :ok, location: @grade_unit_concept }
            else
                format.html { render :edit }
                format.json { render json: @grade_unit_concept.errors, status: :unprocessable_entity }
            end
        end
    end

  # DELETE /grade_unit_concepts/1
  # DELETE /grade_unit_concepts/1.json
  def destroy
    @grade_unit_concept.destroy
    respond_to do |format|
      format.html { redirect_to grade_unit_concepts_url, notice: 'Grade unit concept was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade_unit_concept
      @grade_unit_concept = GradeUnitConcept.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_unit_concept_params
      params.require(:grade_unit_concept).permit(:grade, :chapter, :category, :sub_category, :code, :name, :unit_concept_id)
    end
end