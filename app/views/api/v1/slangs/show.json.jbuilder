json.slang do
  json.extract! @slang, :id, :name, :sticker_url
  json.created_at @format_time.call(@slang.created_at)
  json.user @slang.user, :name, :avatar_url
  json.definitions @definitions do |definition|
    json.extract! definition, :id, :content
    json.created_at @format_time.call(definition.created_at)
    json.user definition.user.name
    json.likes definition.likes.count
    user_like = definition.likes.find_by(user_id: @current_user_id)
    json.user_like_id user_like.id if user_like.present?
  end
  json.dialects @slang.dialect_list
  json.tags @slang.tag_list
end