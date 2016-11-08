json.extract! blog_reply, :id, :blog_id, :user_id, :comment, :group_id, :parent_reply_id, :depth, :order_no, :created_at, :updated_at
json.url blog_reply_url(blog_reply, format: :json)