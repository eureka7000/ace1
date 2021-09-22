json.extract! qrcode, :id, :url, :created_at, :updated_at
json.url qrcode_url(qrcode, format: :json)