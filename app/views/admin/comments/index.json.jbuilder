json.array!(@admin_comments) do |admin_comment|
  json.extract! admin_comment, :id, :comment, :publication_id, :user_id
  json.url admin_comment_url(admin_comment, format: :json)
end
