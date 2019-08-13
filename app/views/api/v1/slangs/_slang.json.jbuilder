json.extract! slang, :id, :name, :sticker_url
json.created_at @format_time.call(slang.created_at)
json.user slang.user, :name, :avatar_url