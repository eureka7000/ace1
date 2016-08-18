json.extract! study_history, :id, :user_id, :unit_concept_id, :segment, :status, :created_at, :updated_at
json.url study_history_url(study_history, format: :json)