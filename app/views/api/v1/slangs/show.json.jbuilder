json.slang do
  json.extract! @slang, :id, :name, :sticker_url
  json.created_at @format_time.call(@slang.created_at)
  json.user @slang.user, :name, :avatar_url
  json.definitions @slang.definitions, partial: 'api/v1/definitions/definition', as: :definition
  json.dialects @slang.dialect_list
  json.tags @slang.tag_list
end