json.array!(@concepts) do |concept|
  json.extract! concept, :id, :category, :sub_category, :concept_code, :concept_name
  json.url concept_url(concept, format: :json)
end
