# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'mikejtodd@gmail.com', fname: 'Michael', lname: 'Todd', password: 'michael')
User.create(email: 'ytmoik@gmail.com', fname: 'Yofred', lname: 'Moik', password: 'yofred')
User.create(email: 'ja.lueth@gmail.com', fname: 'John', lname: 'Lueth', password: 'john')
User.create(email: 'nivram80@gmail.com', fname: 'Todd', lname: 'Nichols', password: 'todd')
Place.create(name: 'Starbucks', desc: "America's favorite corporate coffee.", street: "219 S 72nd St", city: "Omaha", zipcode: "68114");
Place.create(name: 'Blue Line Coffee', desc: "Where dreams go to die.", street: "4924 Underwood Ave", city: "Omaha", zipcode: "68132")
Place.create(name: 'Caffeine Dreams', desc: "Go outside, you dummy.", street: "4524 Farnam St", city: "Omaha", zipcode: "68132")
Group.create(name: 'John\'s Group', desc: "You know it.", mod: 3)
Member.create(group_id: 1, user_id: 1)
Member.create(group_id: 1, user_id: 2)
Member.create(group_id: 1, user_id: 3)
CheckIn.create(user_id: 1, place_id: 1, time_in: Time.now)
CheckIn.create(user_id: 2, place_id: 2, time_in: Time.now)
CheckIn.create(user_id: 3, place_id: 3, time_in: Time.now)