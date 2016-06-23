json.array!(@user_relations) do |user_relation|
  json.extract! user_relation, :id, :user_id, :related_user_id, :relation_type
  json.url user_relation_url(user_relation, format: :json)
end
