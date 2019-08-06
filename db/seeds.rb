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
shawn = User.create!(password: "123456", email: "shawn@peng.com")
puts "Created user."
# Slang.create!(name:"MMP", user: shawn)

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




