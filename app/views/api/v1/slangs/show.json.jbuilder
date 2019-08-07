json.slang do
  json.extract! @slang, :name
  json.user @slang.user.name
  json.definitions @definitions do |definition|
    json.extract! definition, :content
    json.user definition.user.name
    json.likes definition.likes.count
    user_like = definition.likes.find_by(user_id: @current_user_id)
    json.user_like_id user_like.id if user_like.present? 
  end
end