require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
20.times do
  wiki = Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
    )
end
wikis = Wiki.all

# Create my own admin account
sean = User.new(
  name:     'Sean',
  email:    'sean@example.com',
  password: 'password',
  role:     'admin'
  )
sean.skip_confirmation!
sean.save!

#Create Member
 member = User.new(
  name: 'Member',
  email: 'member@example.com',
  password: 'password'
 )
 member.skip_confirmation!
 member.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"