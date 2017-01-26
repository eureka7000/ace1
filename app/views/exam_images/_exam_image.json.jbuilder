json.extract! exam_image, :id, :filename, :width, :height, :created_at, :updated_at
json.url exam_image_url(exam_image, format: :json)