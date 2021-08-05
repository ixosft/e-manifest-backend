# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(username: 'omedale') do |user|
  user.name = 'Test Admin'
  user.role = 4
  user.password = 'Password1'
  user.email = 'admin@gmail.com'
end

User.find_or_create_by(username: 'agent') do |user|
  user.name = 'Test agent'
  user.role = 1
  user.password = 'Password1'
  user.email = 'test@gmail.com'
end
