class UnitConceptsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_unit_concept, only: [:show, :edit, :update, :destroy]
    layout '/layouts/admin_main'

    # GET /unit_concepts
    # GET /unit_concepts.json
    def index
        @unit_concepts = UnitConcept.where('concept_id = ?', params[:concept_id])
    end

    # GET /unit_concepts/1
    # GET /unit_concepts/1.json
    def show
        @concepts = Concept.all
    end

    # GET /unit_concepts/new
    def new
        @unit_concept = UnitConcept.new
    end

    # GET /unit_concepts/1/edit
    def edit
    end

    # POST /unit_concepts
    # POST /unit_concepts.json
    def create
        
        @unit_concept = UnitConcept.new(unit_concept_params)

        respond_to do |format|
            if @unit_concept.save
                format.html { redirect_to @unit_concept, notice: 'Unit concept was successfully created.' }
                format.json { render :show, status: :created, location: @unit_concept }
            else
                format.html { render :new }
                format.json { render json: @unit_concept.errors, status: :unprocessable_entity }
            end
        end
        
    end

  # PATCH/PUT /unit_concepts/1
  # PATCH/PUT /unit_concepts/1.json
  def update
    respond_to do |format|
      if @unit_concept.update(unit_concept_params)
        format.html { redirect_to @unit_concept, notice: 'Unit concept was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit_concept }
      else
        format.html { render :edit }
        format.json { render json: @unit_concept.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_concepts/1
  # DELETE /unit_concepts/1.json
  def destroy
    @unit_concept.destroy
    respond_to do |format|
      format.html { redirect_to unit_concepts_url, notice: 'Unit concept was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_concept
      @unit_concept = UnitConcept.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_concept_params
      params.require(:unit_concept).permit(:code, :name, :level, :concept_id)
    end
end
