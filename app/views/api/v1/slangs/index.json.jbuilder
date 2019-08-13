json.slangs @slangs do |slang|
  json.extract! slang, :id, :name, :sticker_url
  json.created_at @format_time.call(slang.created_at)
  json.user slang.user, :name, :avatar_url
  json.definitions slang.definitions.max_by(5) {|d| d.likes.count}, partial: 'api/v1/definitions/definition', as: :definition
  json.dialects slang.dialect_list[0...5]
  json.tags slang.tag_list[0..5]
end