json.slang do
  json.partial! 'api/v1/slangs/slang', slang: @slang
  json.definitions @slang.definitions.sort_by { |d| d.likes.count }.reverse, partial: 'api/v1/definitions/definition', as: :definition
  json.dialects @slang.dialect_list
  json.tags @slang.tag_list
end
