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
  user.email = 'omedale@gmail.com'
end

User.find_or_create_by(username: 'agent') do |user|
  user.name = 'Test agent'
  user.role = 1
  user.password = 'Password1'
  user.email = 'agent@gmail.com'
end

# User.create(
#   name: 'Test Admin',
#   role: 1,
#   username: 'agent',
#   password: 'Password1',
#   email: 'omedale@gmail.com'
# )
