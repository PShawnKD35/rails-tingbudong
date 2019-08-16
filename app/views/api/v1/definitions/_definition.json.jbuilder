json.extract! definition, :id, :content
json.created_at @format_time.call(definition.created_at)
json.user definition.user, :id, :name
json.likes definition.likes.count
user_like = definition.likes.find_by(user: @current_user) if @current_user.present?
json.user_like_id user_like.id if user_like.present?
if @show_slang.present?
  json.slang definition.slang, :id, :name
end