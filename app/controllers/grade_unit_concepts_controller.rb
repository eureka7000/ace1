class GradeUnitConceptsController < ApplicationController
  before_action :set_grade_unit_concept, only: [:show, :edit, :update, :destroy]

  # GET /grade_unit_concepts
  # GET /grade_unit_concepts.json
  def index
    @grade_unit_concepts = GradeUnitConcept.all
  end

  # GET /grade_unit_concepts/1
  # GET /grade_unit_concepts/1.json
  def show
  end

  # GET /grade_unit_concepts/new
  def new
    @grade_unit_concept = GradeUnitConcept.new
  end

  # GET /grade_unit_concepts/1/edit
  def edit
  end

  # POST /grade_unit_concepts
  # POST /grade_unit_concepts.json
  def create
    @grade_unit_concept = GradeUnitConcept.new(grade_unit_concept_params)

    respond_to do |format|
      if @grade_unit_concept.save
        format.html { redirect_to @grade_unit_concept, notice: 'Grade unit concept was successfully created.' }
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
        format.html { redirect_to @grade_unit_concept, notice: 'Grade unit concept was successfully updated.' }
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
      params.require(:grade_unit_concept).permit(:grade, :chapter, :category, :sub_category, :code, :unit_concept)
    end
end
