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

# create six users
6.times{User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)}

# create two presidents
pres1 = President.new
pres1.user = User.all.first
pres1.save
pres2 = President.create(user: User.all[4])

# create one pizza
pizza = Pizza.create(topping: "cheese", price: 17.0)

# create two events
e1 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
e1.date =  Faker::Time.forward(2, :evening)
e1.deadline = Faker::Time.forward(2, :afternoon)
e1.president = President.first
e1.save

e2 = Event.new(title: Faker::Book.title, description: Faker::Hipster.sentence)
e2.date =  Faker::Time.forward(7, :evening)
e2.deadline = Faker::Time.forward(7, :afternoon)
e2.president = President.last
e2.save

# create ten orders
10.times{Order.create(user: User.all.sample, event: Event.all.sample)}

# create thirty slices
30.times{Slice.create(order:Order.all.sample, pizza: pizza)}




