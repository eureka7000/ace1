json.extract! discussion_image, :id, :discussion_id, :filename, :width, :height, :created_at, :updated_at
json.url discussion_image_url(discussion_image, format: :json)