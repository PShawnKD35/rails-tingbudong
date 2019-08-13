json.slangs @slangs do |slang|
  json.partial! 'api/v1/slangs/slang', slang: slang
  json.definitions slang.definitions.max_by(5) {|d| d.likes.count}, partial: 'api/v1/definitions/definition', as: :definition
  json.dialects slang.dialect_list[0...5]
  json.tags slang.tag_list[0..5]
end