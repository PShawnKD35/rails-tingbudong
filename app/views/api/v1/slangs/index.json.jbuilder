json.slangs @slangs do |slang|
  json.extract! slang, :id, :name, :sticker_url
  json.created_at @format_time.call(slang.created_at)
  json.user slang.user, :name, :avatar_url
  json.definitions slang.definitions.max_by(5) {|d| d.likes.count} do |definition|
    json.extract! definition, :id, :content
    json.created_at @format_time.call(definition.created_at)
    json.user definition.user.name
    json.likes definition.likes.count
  end
  json.regions slang.region_list[0...5]
  json.tags slang.tag_list[0..5]
  # json.tags slang.tags[0...10]
end