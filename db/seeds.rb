# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
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
shawn = User.create!(name: "supershawn", password: "123456", email: "shawn@peng.com", avatar_url: "https://avatars2.githubusercontent.com/u/6245208?s=40&v=4")
puts "Created user."

# -------------------------
# word definitions
# -------------------------
word = 'word'
text = Rails.root.join('db','jikipedia.html')

html_file = File.open(text).read
html_doc = Nokogiri::HTML(html_file)

puts "Creating slangs and definitions..."
html_doc.search('.tile').each do |element|
  slang = Slang.create!(
  name: element.search('h1.title').text,
  user: shawn)

  Definition.create!(
  content: element.search('.brax-render').text,
  slang: slang,
  user: shawn
  )
end
puts "Created #{Slang.count} slangs, and #{Definition.count} definitions."

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
