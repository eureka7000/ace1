json.array!(@units) do |unit|
  json.extract! unit, :id, :name, :code, :sub_category_id
  json.url unit_url(unit, format: :json)
end
