FactoryGirl.define do
  factory :user do
    name "Sally Bishop"
    email "sally@bishop.com"
    password "12345678"
  end

  factory :event do
    title "Pizza Party"
    description "Party like it's 1984"
    date "2016-03-20 22:00:00"
    deadline "2016-03-20 20:00:00"
    president_id "1"
  end

  factory :president do
    user_id "1"
  end

  factory :cheese_pizza, class: "Pizza" do
    topping "Cheese"
    price "22.00"
  end

  factory :mushroom_pizza, class: "Pizza" do
    topping "Mushroom"
    price "25.00"
  end
end
