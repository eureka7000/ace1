json.array!(@sub_units) do |sub_unit|
  json.extract! sub_unit, :id, :name, :code, :unit_id, :grade
  json.url sub_unit_url(sub_unit, format: :json)
end
