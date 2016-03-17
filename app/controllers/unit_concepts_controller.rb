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
        
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @unit_concept }
        end
        
    end

    # GET /unit_concepts/new
    def new
        @unit_concept = UnitConcept.new
    end

    # GET /unit_concepts/1/edit
    def edit
    end

    def create
        @unit_concept = UnitConcept.new(unit_concept_params)
        @unit_concept.save
        
        ret = {
            status: 'success'
        }
        
        render json: ret
    end

    def update
        @unit_concept.update(unit_concept_params)
        ret = {
            status: 'success'
        }
        
        render json: ret
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
      params.require(:unit_concept).permit(:code, :name, :level, :concept_id, :grade)
    end
end
