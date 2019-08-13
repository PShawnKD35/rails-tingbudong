json.slang do
  json.partial! 'api/v1/slangs/slang', slang: @slang
  json.definitions @slang.definitions, partial: 'api/v1/definitions/definition', as: :definition
  json.dialects @slang.dialect_list
  json.tags @slang.tag_list
  json.favorited @favorited
end