class ContentsController < ApplicationController

    before_action :authenticate_user!

    def index
        
        @view_type = params[:view_type].blank? ? '1' : params[:view_type]
        @step = params[:step].blank? ? '1' : params[:step]
        @category = params[:category]
        @sub_category = params[:sub_category]
        @concept_id = params[:concept_id]
        
        if @step == '3'
            @concepts = Concept.where('category = ? and sub_category = ?', @category, @sub_category)
        elsif @step == '4'
            @concept = Concept.find(@concept_id)
            @unit_concepts = UnitConcept.where('concept_id = ?', @concept_id)     
        end    
        
    end
    
    def show
        @unit_concept = UnitConcept.find(params[:id])
        @unit_concept_descs = @unit_concept.unit_concept_descs.order('desc_type')
    end    

end
