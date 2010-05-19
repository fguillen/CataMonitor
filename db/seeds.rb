# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

user = Factory(:user, :password => 'wadus', :password_confirmation => 'wadus')

puts "User Created:"
puts "-------"
puts "Email: #{user.email}"
puts "Password: wadus"


puts "Creating Query"
query = Factory(:query, :user => user)

puts "Creating Mentions"
mention_types = %w(blogs microblogs bookmarks comments events images news videos audio questions networks)
100.times { Factory(:mention, :query => query, :m_type => mention_types[rand(mention_types.size)]) }