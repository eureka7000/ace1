class StudyHistory < ActiveRecord::Base
    
    SEGMENTS = {
        "concept" => "개념",
        "concept explanation" => "개념설명",
        "video" => "비디오",
        "exercise" => "연습문제",
        "self evaluation" => "자기평가"
    }
    
    def self.update_study_history(params)
        
        study_history = StudyHistory.where('user_id = ? and unit_concept_id = ? and segment = ? and status = ?', params[:user_id], params[:unit_concept_id], params[:segment], params[:status])
        
        if study_history.count > 0
            study_history[0].study_count = study_history[0].study_count + 1
            study_history[0].save
        else
            study_history = StudyHistory.new
            study_history.user_id = params[:user_id]
            study_history.unit_concept_id = params[:unit_concept_id]
            study_history.segment = params[:segment]
            study_history.status = params[:status]
            study_history.save
        end        
        
    end    
    
end
