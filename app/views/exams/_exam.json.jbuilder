json.extract! exam, :id, :year, :month, :exam_type, :number, :score, :contents, :created_at, :updated_at
json.url exam_url(exam, format: :json)