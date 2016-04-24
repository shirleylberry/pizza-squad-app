# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Event.destroy_all
Order.destroy_all
President.destroy_all
Pizza.destroy_all
Slice.destroy_all
Restaurant.destroy_all

sammy = User.create(name: "Sammy Mernick", email: "smernick3@gmail.com", password: "zazazaza")
shirley = User.create(name: "Shirley Berry ", email: "shirleylberry@gmail.com", password: "zazazaza")
anna = User.create(name: "Anna Nigma", email: "anna.nigma@yahoo.com", password: "zazazaza")

6.times{User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)}

pres1 = President.new
pres1.user = sammy
pres1.save

pres2 = President.new
pres2.user = shirley
pres2.save

pres3 = President.new
pres3.user = anna
pres3.save

restaurant1 = Restaurant.create(name: "Joe's Pizza")
restaurant2 = Restaurant.create(name: "FiDi Pizza")
restaurant3 = Restaurant.create(name: "Two Bros Pizza")

pizza = Pizza.create(topping: "cheese", price: 17.0, indiv_piece_price: 1.50, restaurant: restaurant1 )
pizza2 = Pizza.create(topping: "Mushroom", price: 22.0, indiv_piece_price: 2.50, restaurant: restaurant1)
pizza3 = Pizza.create(topping: "pepperoni", price: 30.0, indiv_piece_price: 2.75, restaurant: restaurant1)

pizza4 = Pizza.create(topping: "cheese", price: 21.0, indiv_piece_price: 1.00, restaurant:restaurant2  )
pizza5 = Pizza.create(topping: "Mushroom", price: 18.0, indiv_piece_price: 2.75, restaurant: restaurant2)
pizza6 = Pizza.create(topping: "pepperoni", price: 15.0, indiv_piece_price: 2.00, restaurant:restaurant2 )

pizza7 = Pizza.create(topping: "cheese", price: 19.0, indiv_piece_price: 2.00, restaurant: restaurant3 )
pizza8 = Pizza.create(topping: "Mushroom", price: 20.0, indiv_piece_price: 3.50, restaurant:restaurant3 )
pizza9 = Pizza.create(topping: "pepperoni", price: 27.0, indiv_piece_price: 4.75, restaurant: restaurant3)

pizzas = [pizza, pizza2, pizza3]
pizzas2 = [pizza4, pizza5, pizza6]
pizzas3 = [pizza7, pizza8, pizza9]



e1 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
date =  Faker::Time.forward(2, :evening)
e1.deadline = (date - 3.hours).to_s
e1.date = date.to_s
e1.president = pres1
e1.restaurant = restaurant1
e1.save


e2 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
date =  Faker::Time.forward(7, :evening)
e2.deadline = (date - 2.hours).to_s
e2.date = date.to_s
e2.president = pres2
e2.restaurant = restaurant2
e2.save

e3 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
date =  Faker::Time.forward(4, :evening)
e3.deadline = (date - 2.hours).to_s
e3.date = date.to_s
e3.president = pres2
e3.restaurant = restaurant3
e3.save


Event.all.each do |event|
  8.times{Order.create(user: User.all.sample, event: event)}
end

orders1 = Order.all.slice(0, 10)
orders2 = Order.all.slice(10, 10)
orders3 = Order.all.slice(19, 10)


170.times{Slice.create(order: orders1.sample, pizza: pizzas.sample)}
111.times{Slice.create(order: orders2.sample, pizza: pizzas2.sample)}
68.times{Slice.create(order: orders3.sample, pizza: pizzas3.sample)}
