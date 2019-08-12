json.user do
  json.extract! @user, :name, :avatar_url, :email
  json.created_at @format_time.call(@user.created_at)
end
json.slangs @user.slangs do |slang|
  json.extract! slang, :id, :name, :sticker_url
  json.created_at @format_time.call(slang.created_at)
  # json.user slang.user, :name, :avatar_url
end
json.definitions @user.definitions, partial: 'api/v1/definitions/definition', as: :definition
