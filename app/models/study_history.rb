class StudyHistory < ActiveRecord::Base
    
    belongs_to :user
    belongs_to :unit_concept
    
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
    
    def self.get_study_history_detail(user_id)
        
        str = "select a.unit_concept_id, b.name as unit_concept_name, b.id, c.concept_name, c.id,
                    sum(case when a.segment = 'concept' and a.status = 'start' then 1 else 0 end) as concept_start,
                    sum(case when a.segment = 'concept' and a.status = 'finish' then 1 else 0 end) as concept_finish,
                    sum(case when a.segment = 'concept_explanation' and a.status = 'start' then 1 else 0 end) as concept_explanation_start,
        	        sum(case when a.segment = 'concept_explanation' and a.status = 'finish' then 1 else 0 end) as concept_explanation_finish,
                    sum(case when a.segment = 'exercise' and a.status = 'start' then 1 else 0 end) as exercise_start,
        	        sum(case when a.segment = 'exercise' and a.status = 'finish' then 1 else 0 end) as exercise_finish,
                    sum(case when a.segment = 'video' and a.status = 'start' then 1 else 0 end) as video,
        	        sum(case when a.segment = 'self_evaluation' and a.status = 'start' then 1 else 0 end) as self_evaluation   
                from study_histories a, unit_concepts b, concepts c
                where a.user_id = #{user_id}
                and a.unit_concept_id = b.id
                and b.concept_id = c.id
                group by a.unit_concept_id
                order by c.id, b.id"
                
        StudyHistory.find_by_sql(str)        
        
    end    
    
    def self.get_study_history(user_id, page)
        
        str = "select history.user_id, users.user_name, users.grade, schools.name, history.concept_count, history.last_study, users.last_sign_in_at from (
            select t.user_id, sum(t.concept_count) concept_count, max(t.concept_studying) last_study from (
                select d.user_id, count(d.concept_name) as concept_count, '' as concept_studying from (
	                select a.user_id, c.concept_name from (
		                select user_id, unit_concept_id 
		                from study_histories
		                where status = 'finish' "
        
        unless user_id.nil?
            str += " and user_id in ( select related_user_id from user_relations where user_id = #{user_id} )"
        end    
        
        str += " group by user_id, unit_concept_id
	                ) a, unit_concepts b, concepts c
	                where a.unit_concept_id = b.id
	                and b.concept_id = c.id
	                group by a.user_id, c.concept_name
                ) d
            group by d.user_id

            union all
 
            select a.user_id, 0 as concept_count, d.concept_name
            from study_histories a, 
	        (
		        select user_id, max(created_at) created_at
		        from study_histories 
		        group by user_id 
	         ) b, unit_concepts c, concepts d
	         where a.created_at = b.created_at "
             
        unless user_id.nil?
            str += " and a.user_id in ( select related_user_id from user_relations where user_id = #{user_id} )"
        end    
                 
        str += "        and a.unit_concept_id = c.id
	                    and c.concept_id = d.id    
                     ) t
                     group by t.user_id
                 ) history, users
                 left outer join schools on users.school_id = schools.id
                 where history.user_id = users.id"
                 
        StudyHistory.paginate_by_sql(str, :page => page, :per_page => 30)                 
        
    end    
    
end
