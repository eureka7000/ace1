json.array!(@unit_concepts) do |unit_concept|
  json.extract! unit_concept, :id, :code, :name, :level
  json.url unit_concept_url(unit_concept, format: :json)
end
