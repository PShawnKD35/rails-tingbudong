json.slang do
  json.extract! @slang, :name
  json.user @slang.user.email
  json.definitions @definitions do |definition|
    json.extract! definition, :content, :sticker_url
    json.user definition.user.email
    json.likes definition.likes.count
    json.user_like definition.likes.find_by(user_id: @current_user_id)
  end
end