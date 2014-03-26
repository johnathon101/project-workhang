# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Group.create(name: "Pro Rubyists Unite", desc: "Group where we make fun of other languages", mod: [1])
# Place.create(name: 'Starbucks', desc: "America's favorite coprorate coffee", street: "100 Broadway", city: "Omaha", zipcode: "68114", user_id: [1], lat: [41.258314], lng: [-96.023587], occupied: true)
User.create(fname: "John", lname: "Lueth", email: "ja.lueth@gmail.com", password: "password", password_confirmation: "password")
User.create(fname: "Yofred", lname: "Moik", email: "ytmoik@gmail.com", password: "password", password_confirmation: "password")
User.create(fname: "Michael", lname: "Todd", email: "mikejtodd@gmail.com", password: "password", password_confirmation: "password")
Group.create(name: "Pro Rubyists Unite", desc: "Group where we make fun of other languages", mod: 2)
Member.create(group_id: 1, user_id: 1)
Member.create(group_id: 1, user_id: 2)
Group.create(name: "Solo Ruby", desc: "Group where we sit by ourselves.", mod: 3)
Member.create(group_id: 2, user_id: 3)