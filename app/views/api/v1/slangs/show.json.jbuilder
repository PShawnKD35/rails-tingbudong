json.slang do
  json.extract! @slang, :id, :name, :sticker_url, :created_at
  json.user @slang.user, :name, :avatar_url
  json.definitions @definitions do |definition|
    json.extract! definition, :id, :content, :created_at
    json.user definition.user.name
    json.likes definition.likes.count
    user_like = definition.likes.find_by(user_id: @current_user_id)
    json.user_like_id user_like.id if user_like.present?
  end
  json.regions @slang.region_list
  json.tags @slang.tag_list
end