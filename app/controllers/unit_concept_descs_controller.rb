class UnitConceptDescsController < ApplicationController

    def create
        
        @unit_concept_desc = UnitConceptDesc.new(unit_concept_desc_params)
        @unit_concept = UnitConcept.find(params[:unit_concept_desc][:unit_concept_id])

        respond_to do |format|
            if @unit_concept_desc.save
                format.html { redirect_to @unit_concept, notice: 'Explanation Desc was successfully created.' }
            else
                format.html { redirect_to '/' }
            end
        end
        
    end


    private

    def unit_concept_desc_params
        params.require(:unit_concept_desc).permit(:memo, :file_name, :unit_concept_id)
    end
    
end