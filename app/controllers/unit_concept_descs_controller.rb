class UnitConceptDescsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_unit_concept_desc, only: [:show, :edit, :update, :destroy]

    def create
        
        @unit_concept_desc = UnitConceptDesc.new(unit_concept_desc_params)
        @unit_concept_desc.save
        
        @unit_concept = UnitConcept.find(params[:unit_concept_desc][:unit_concept_id])

        respond_to do |format|
            format.html { redirect_to "/unit_concepts/#{@unit_concept.id}?desc_type=#{params[:unit_concept_desc][:desc_type]}", notice: 'Explanation Desc was successfully created.' }
        end
        
    end
    
    def destroy
        
        unit_concept = @unit_concept_desc.unit_concept
        @unit_concept_desc.destroy

        
        respond_to do |format|
            format.html { redirect_to "/unit_concepts/#{unit_concept.id}" , notice: 'Unit concept was successfully destroyed.' }
            format.json { head :no_content }
        end
        
    end    


    private
    
    def set_unit_concept_desc
        @unit_concept_desc = UnitConceptDesc.find(params[:id])
    end    

    def unit_concept_desc_params
        params.require(:unit_concept_desc).permit(:memo, :file_name, :unit_concept_id, :desc_type, :video, :link)
    end
    
end