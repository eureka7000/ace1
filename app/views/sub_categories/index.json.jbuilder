json.array!(@sub_categories) do |sub_category|
  json.extract! sub_category, :id, :name, :code, :category_id
  json.url sub_category_url(sub_category, format: :json)
end
