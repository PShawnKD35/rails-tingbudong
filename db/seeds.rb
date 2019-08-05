# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destructing..."
if Rails.env.development?
  Like.destroy_all
  Definition.destroy_all
  Slang.destroy_all
  User.destroy_all
end

puts "Generating..."
shawn = User.create!(password: "123456", email: "shawn@peng.com")
Slang.create!(name:"MMP", user: shawn)