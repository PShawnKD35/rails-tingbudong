json.slangs @slangs do |slang|
  json.extract! slang, :name, :sticker_url
  json.user slang.user, :name, :avatar_url
  json.definitions slang.definitions.max_by(5) {|d| d.likes.count} do |definition|
    json.extract! definition, :content
    json.user definition.user.name
    json.likes_count definition.likes.count
  end
  # json.tags slang.tags[0...10]
end