json.extract! textbook, :id, :name, :price, :grade, :sub_category, :created_at, :updated_at
json.url textbook_url(textbook, format: :json)