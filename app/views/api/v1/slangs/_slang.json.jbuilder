json.extract! slang, :id, :name, :pinyin, :sticker_url
json.created_at @format_time.call(slang.created_at)
json.user slang.user, :id, :name, :avatar_url