json.array!(@grade_unit_concepts) do |grade_unit_concept|
  json.extract! grade_unit_concept, :id, :grade, :chapter, :category, :sub_category, :code, :unit_concept
  json.url grade_unit_concept_url(grade_unit_concept, format: :json)
end
