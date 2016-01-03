json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :user_id, :school_id, :confirm_yn, :confirmed_at, :comfirmed_id
  json.url teacher_url(teacher, format: :json)
end
