# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'


puts "Destructing..."
if Rails.env.development?
  Like.destroy_all
  Definition.destroy_all
  Slang.destroy_all
  User.destroy_all
end

puts "Generating user..."
SHAWN = User.create!(name: "supershawn", password: "123456", email: "shawn@peng.com", avatar_url: "https://avatars2.githubusercontent.com/u/6245208?s=40&v=4")
puts "Created user."

# -------------------------
# jiki slangs
# -------------------------
word = 'word'
text = Rails.root.join('db','jikipedia.html')

html_file = File.open(text).read
html_doc = Nokogiri::HTML(html_file)

puts "Creating slangs and definitions..."
html_doc.search('.tile').each do |element|
  slang = Slang.create!(
  name: element.search('h1.title').text,
  user: SHAWN)
# puts "Creating slangs and definitions..."
# html_doc.search('.tile').each do |element|
#   title = element.search('h1.title').text,
#   puts title
#   unless Slang.exists?(name: title)
#     slang = Slang.create!(
#       name: element.search('h1.title').text,
#     user: SHAWN)


  Definition.create!(
  content: element.search('.brax-render').text,
  slang: slang,
  user: SHAWN)
end
puts "Created #{Slang.count} slangs, and #{Definition.count} definitions."


# ----------------
# difang slangs
# ----------------

require 'csv'

def seed_words(filepath, name)
  CSV.foreach(filepath) do |row|
    next if row[0].blank?
    slang = Slang.create!(name: row[0], user: SHAWN)
    slang.dialect_list.add(name)

    Definition.create!(content: row[1], slang: slang, user: SHAWN)
  end
  puts "Created #{Slang.count} slangs, and #{Definition.count} definitions."
end

f1 = 'db/dongbei.csv'
f2 = 'db/fujian.csv'
f3 = 'db/guangdong.csv'
f4 = 'db/hakka.csv'
f5 = 'db/taiwan.csv'
f6 = 'db/sichuan .csv'

seed_words(f1, "东北话")
seed_words(f2, "闽南话")
seed_words(f3, "广东话")
seed_words(f4, "客家话")
seed_words(f5, "台语话")
seed_words(f6, "四川话")



# sample definition for test
# puts "creating sample difeinitions and likes..."
# slang = Slang.first
# indexes = (0...10).to_a
# likes_count = 0
# indexes.each do |i|
#   definition = Definition.create!(content: "sample#{i}", user: shawn, slang: slang)
#   (0...10).to_a.sample.times do
#     Like.create!(user: shawn, definition: definition)
#     likes_count += 1
#   end
# end
# puts "#{indexes.last + 1} definitions and #{likes_count} likes created"
