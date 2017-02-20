class UnitConceptExerciseHistory < ActiveRecord::Base
    
    belongs_to :unit_concept_desc
    belongs_to :user
    
    validates_presence_of :user_id, :unit_concept_desc_id

    def self.get_student_exercise_histories(user_id, unit_concept_id)

        query = "select a.unit_concept_id, c.name as unit_concept_name , a.id as unit_concept_desc_id, a.memo, b.user_id, group_concat(b.ox separator ' ') as history
                from unit_concept_descs a, unit_concept_exercise_histories b, unit_concepts c
                where a.id = b.unit_concept_desc_id
                and c.id = a.unit_concept_id
                and b.user_id = #{user_id}
                and a.unit_concept_id = #{unit_concept_id}
                group by a.id, b.user_id
                order by memo"

        @unit_concept_exercises_histories = UnitConceptExerciseHistory.find_by_sql(query)

        @unit_concept_exercises_histories
    end
end
