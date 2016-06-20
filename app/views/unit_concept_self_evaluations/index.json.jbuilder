json.array!(@unit_concept_self_evaluations) do |unit_concept_self_evaluation|
  json.extract! unit_concept_self_evaluation, :id, :unit_concept_id, :evaluation, :comment
  json.url unit_concept_self_evaluation_url(unit_concept_self_evaluation, format: :json)
end
