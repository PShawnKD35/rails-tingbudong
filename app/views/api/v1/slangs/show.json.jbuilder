json.slang do
  json.extract! @slang, :name
  json.user @slang.user.email
  json.definitions @definitions do |definition|
    json.extract! definition, :content, :sticker_url
    json.user definition.user.email
    json.likes definition.likes.count
    user_like = definition.likes.find_by(user_id: @current_user_id)
    json.user_like_id user_like.id if user_like.present? 
  end
end