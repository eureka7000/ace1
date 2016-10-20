class UnitConceptDescsController < ApplicationController

    before_action :authenticate_admin_user!
    before_action :set_unit_concept_desc, only: [:show, :edit, :update, :destroy]
    
    def get_not_saved_images
        
        @lists = UnitConceptDesc.where("width is null and desc_type in ('1','2','3','7')").limit(50)
        render :layout => 'admin_main'
                
    end    
    

    def create
        
        if params[:unit_concept_desc][:desc_type] == 'i'
        
            params[:unit_concept_desc][:file_name].each do | image |
            
                unit_concept_desc = UnitConceptDesc.new
            
                filename = image.original_filename.split('.')[0]
                div = filename.last(1)
            
                if div == 'c'
                    unit_concept_desc.desc_type = '1'
                elsif div == 'e'
                    unit_concept_desc.desc_type = '2'
                elsif div == 's'
                    unit_concept_desc.desc_type = '3'
                elsif div == 'a'    
                    unit_concept_desc.desc_type = '7'
                end
            
                unit_concept_desc.memo = filename
                unit_concept_desc.file_name = image
                unit_concept_desc.unit_concept_id = params[:unit_concept_desc][:unit_concept_id]
                unit_concept_desc.save
            
            end
            
        else
            unit_concept_desc = UnitConceptDesc.new(unit_concept_desc_params)
            unit_concept_desc.save
        end        
            
        respond_to do |format|
            format.html { redirect_to "/unit_concepts/#{params[:unit_concept_desc][:unit_concept_id]}?desc_type=#{params[:unit_concept_desc][:desc_type]}", notice: 'Explanation Desc was successfully created.' }
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
    
    def update
        
        ret = { status: 'ok', id: 'div'+params[:id] }
        
        if @unit_concept_desc.update(unit_concept_desc_params)
            render json: ret
        end
        
    end


    private
    
    def set_unit_concept_desc
        @unit_concept_desc = UnitConceptDesc.find(params[:id])
    end    

    def unit_concept_desc_params
        params.require(:unit_concept_desc).permit(:memo, :file_name, :unit_concept_id, :desc_type, :video, :link, :width, :height)
    end
    
end