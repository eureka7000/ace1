class UnitConceptDesc < ActiveRecord::Base
    
    belongs_to :unit_concept
    has_many :unit_concept_exercise_solutions, :dependent => :delete_all
    has_many :unit_concept_desc_solution_links, :dependent => :delete_all
    
    mount_uploader :file_name, ImageUploader

    def self.get_unit_concept_desc_count(unit_concept_id)
        str = "select distinct desc_type from unit_concept_descs
where unit_concept_id = #{unit_concept_id}
and not desc_type = ''
and not desc_type = 5"
        @unit_concept_desc_count = UnitConceptDesc.find_by_sql(str).count

        count = @unit_concept_desc_count.to_i

        unless @unit_concept_desc_count == 1
            count = count * 2
        end

        count
    end
end
