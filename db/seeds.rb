# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
michael = User.new(email: 'mikejtodd@gmail.com', fname: 'Michael', lname: 'Todd', password: 'awesome', password_confirmation: 'awesome')
michael.groups << Group.create(name: 'Ruby', desc: 'The very best.', mod: 1)
michael.save
Place.create(name: 'Blue Line Coffee', street: '749 N 14th St', city: 'Omaha, NE', zipcode: '68102', lat: '41.266916', lng: '-95.934190', occupied: true)
CheckIn.create(place_id: 1, user_id: 1)