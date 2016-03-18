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

pizza = Pizza.create(topping: "cheese", price: 17.0, indiv_piece_price: 1.50)
pizza2 = Pizza.create(topping: "Mushroom", price: 22.0, indiv_piece_price: 2.50)
pizza3 = Pizza.create(topping: "pepperoni", price: 30.0, indiv_piece_price: 2.75)

pizzas = [pizza, pizza2, pizza3]

e1 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
date =  Faker::Time.forward(2, :evening)
e1.deadline = (date - 3.hours).to_s
e1.date = date.to_s
e1.president = pres1
e1.save


e2 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
date =  Faker::Time.forward(7, :evening)
e2.deadline = (date - 2.hours).to_s
e2.date = date.to_s
e2.president = pres2
e2.save

e3 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
date =  Faker::Time.forward(4, :evening)
e3.deadline = (date - 2.hours).to_s
e3.date = date.to_s
e3.president = pres2
e3.save

30.times{Order.create(user: User.all.sample, event: Event.all.sample)}

150.times{Slice.create(order:Order.all.sample, pizza: pizzas.sample)}
