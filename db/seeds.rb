# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
john = User.new(email: 'ja.lueth@gmail.com', fname: 'Johnathon', lname: 'Lueth', password: 'cool', password_confirmation: 'cool')
john.save
john_check_in = User.find(1)
john_check_in.update_attributes(checked_in: true)
yofred = User.new(email: 'ytmoik@gmail.com', fname: 'Yofred', lname: 'Moik', password: 'groovy', password_confirmation: 'groovy')
yofred.groups << Group.create(name: 'Second', desc: 'The very very best.', mod: 2)
yofred.save
yofred_check_in = User.find(2)
yofred_check_in.update_attributes(checked_in: true)
john.groups << Member.create(group_id: 1, name: 'First', desc: 'The very very very best.', mod: 2)
michael = User.new(email: 'mikejtodd@gmail.com', fname: 'Michael', lname: 'Todd', password: 'awesome', password_confirmation: 'awesome')
michael.groups << Group.create(name: 'Third', desc: 'The very best.', mod: 3)
michael.save
michael_check_in = User.find(3)
michael_check_in.update_attributes(checked_in: true)
Place.create(name: 'Blue Line Coffee', street: '749 N 14th St', city: 'Omaha, NE', zipcode: '68102', lat: '41.266916', lng: '-95.934190', occupied: true)
CheckIn.create(place_id: 1, user_id: 1)