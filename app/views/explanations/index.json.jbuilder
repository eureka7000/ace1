json.array!(@explanations) do |explanation|
  json.extract! explanation, :id, :code
  json.url explanation_url(explanation, format: :json)
end
