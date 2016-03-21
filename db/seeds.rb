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


order1 = Order.create(user: User.all.sample, event: e1)
order2 = Order.create(user: User.all.sample, event: e1)
order3 = Order.create(user: User.all.sample, event: e1)
order4 = Order.create(user: User.all.sample, event: e1)
order5 = Order.create(user: User.all.sample, event: e1)
order6 = Order.create(user: User.all.sample, event: e1)
order7 = Order.create(user: User.all.sample, event: e1)
order8 = Order.create(user: User.all.sample, event: e1)
order9 = Order.create(user: User.all.sample, event: e1)
order10 = Order.create(user: User.all.sample, event: e1)
order11 = Order.create(user: User.all.sample, event: e2)
order12 = Order.create(user: User.all.sample, event: e2)
order13 = Order.create(user: User.all.sample, event: e2)
order14 = Order.create(user: User.all.sample, event: e2)
order15 = Order.create(user: User.all.sample, event: e2)
order16 = Order.create(user: User.all.sample, event: e2)
order17 = Order.create(user: User.all.sample, event: e2)
order18 = Order.create(user: User.all.sample, event: e2)
order19 = Order.create(user: User.all.sample, event: e2)
order20 = Order.create(user: User.all.sample, event: e2)
order21 = Order.create(user: User.all.sample, event: e3)
order22 = Order.create(user: User.all.sample, event: e3)
order23 = Order.create(user: User.all.sample, event: e3)
order24 = Order.create(user: User.all.sample, event: e3)
order25 = Order.create(user: User.all.sample, event: e3)
order26 = Order.create(user: User.all.sample, event: e3)
order27 = Order.create(user: User.all.sample, event: e3)
order28 = Order.create(user: User.all.sample, event: e3)
order29 = Order.create(user: User.all.sample, event: e3)
order30 = Order.create(user: User.all.sample, event: e3)

orders1 = [order1, order2, order3, order4, order5, order6, order7, order8, order9, order10]
orders2 = [order11, order12, order13, order14, order15, order16, order17, order18, order19, order20]
orders3 = [order21, order22, order23, order24, order25, order26, order27, order28, order29, order30]



150.times{Slice.create(order: orders1.sample, pizza: pizzas.sample)}
150.times{Slice.create(order: orders2.sample, pizza: pizzas2.sample)}
150.times{Slice.create(order: orders3.sample, pizza: pizzas3.sample)}
