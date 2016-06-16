json.array!(@blogs) do |blog|
  json.extract! blog, :id, :blog_type, :title, :content, :user_id
  json.url blog_url(blog, format: :json)
end
