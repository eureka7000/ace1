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
        @unit_concept_descs = @unit_concept.unit_concept_descs.where('desc_type=1').order(:memo)
        
        link_query = "select a.name, a.id, a.code from unit_concepts a, unit_concept_descs b " +
                     "where b.unit_concept_id = #{@unit_concept.id} " +
                     "and b.desc_type = 5 and b.link = a.id " 
        
        # @links = ActiveRecord::Base.connection.execute(link_query)
        @links = UnitConceptDesc.find_by_sql(link_query)
    end    
    
end
