# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

if Rails.env.development?
  puts "Destructing..."
  Like.destroy_all
  Definition.destroy_all
  Slang.destroy_all
  User.destroy_all
end

puts "Generating user..."
PAUL = User.find_by_name "Paulina"
if PAUL.nil?
  PAUL = User.create!(name: "Paulina", password: "123456", email: "paulina@tingbudong.net", avatar_url: "https://omohikane.com/wp-content/uploads/2017/02/result.png")
end
puts "Created user."

# -------------------------
# jiki slangs
# -------------------------
word = 'word'
text = Rails.root.join('db', 'jikipedia.html')

html_file = File.open(text).read
html_doc = Nokogiri::HTML(html_file)

# puts "Creating slangs and definitions..."
# html_doc.search('.tile').each do |element|
#   slang = Slang.create!(
#   name: element.search('h1.title').text,
#   user: SHAWN)

# puts "Creating slangs and definitions..."
puts "Creating slangs and definitions..."
html_doc.search('.tile').each do |element|
  title = element.search('h1.title').text
  # puts title
  next if Slang.exists?(name: title)

  slang = Slang.create!(
    name: element.search('h1.title').text,
    user: PAUL
  )

  Definition.create!(
    content: element.search('.brax-render').text,
    slang: slang,
    user: PAUL
  )
end
puts "Created #{Slang.count} slangs, and #{Definition.count} definitions."

# ----------------
# difang slangs
# ----------------
require 'csv'

def seed_words(filepath, name)
  CSV.foreach(filepath) do |row|
    next if row[0].blank?

    slang = Slang.find_by(name: row[0], user: PAUL)
    if slang.nil?
      slang = Slang.find_or_create_by(name: row[0], user: PAUL)
      content_to_write = row[1]
    else
      content_to_write = "#{name}：#{row[1]}"
    end
    puts row[0]
    slang.dialect_list.add(name)
    slang.save

    # next if row[1].exists?
    definition = Definition.find_or_create_by(content: content_to_write, slang: slang, user: PAUL)
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
seed_words(f5, "台语")
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
