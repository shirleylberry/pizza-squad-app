# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  date         :datetime
#  title        :string
#  description  :text
#  deadline     :datetime
#  president_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Event < ActiveRecord::Base
  has_many :orders
  has_many :users, through: :orders
  has_many :slices, through: :orders
  belongs_to :president
  belongs_to :restaurant

  validates :president_id, presence: true
  validates :title, presence: true
  validates :date, presence: true
  validates :deadline, presence: true
  validates :restaurant_id, presence: true
  validate :deadline_before_date, unless: Proc.new {|e| e.date.nil? || e.deadline.nil?}

  #### VALIDATIONS ####

  def deadline_before_date
    if deadline > (date - 1.hours).to_datetime
      self.errors.add(:deadline, "must be at least an hour before date")
    end
  end

  ####################

  def date=(date)
    write_attribute(:date, Chronic::parse(date))
  end

  def deadline=(deadline)
    write_attribute(:deadline, Chronic::parse(deadline))
  end

  def time_left
    t = deadline - DateTime.now
    return "Closed" if t < 0
    mm, ss = t.divmod(60)            #=> [4515, 21]
    hh, mm = mm.divmod(60)           #=> [75, 15]
    dd, hh = hh.divmod(24)           #=> [3, 3]
    "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
  end

  def active?
    Time.now > self.date ? false : true
  end

  def self.active_events
    Event.where("events.date > ?", Time.now).sort { |a, b| b.date <=> a.date }
  end

  #### ANALYTICS ####

  # GROUP


  def self.total_cost_per_event
    self.all.map { |event| event.total_price }
  end
  #=> [20.0, 18.0, 53.0]

  def self.average_cost
    (total_cost_per_event.inject(0) { |sum, event_cost| sum + event_cost } / self.all.size ).round(2)
  end
  #=> 30.33

  def self.total_orders_per_event
    self.all.map { |event| event.orders.count }
  end
  #=> [3, 3, 7]

  def self.average_num_orders
    (total_orders_per_event.inject(0) { |sum, num_orders| sum + num_orders } / self.all.size.to_f ).round(2)
  end
  #=> 4.33

  def self.total_slices_per_event
    self.all.map do |event|
      event.orders.inject(0) { |sum, order| sum + order.slices.count }
    end
  end
  #=> [9, 7, 25]

  def self.average_num_slices
    (total_slices_per_event.inject(0) { |sum, num_slices| sum + num_slices } / self.all.size.to_f ).round(2)
  end
  #=> 13.67

  # INDIVIDUAL

  def slices_by_type
    Slice.joins(:order, :pizza).where("orders.event_id = ?", self).group("pizzas.topping").count
  end

  #### ORDERING FUNCTIONALITY ####

  # def get_pie_types_counts_hash
  #   # pie_types = {"cheese": 10, "mushroom": 4, "pepperoni": 3}
  #   pie_types_hash = self.orders.each_with_object({}) do |order, orders_hash|
  #     orders_hash[order.id] = order.slices_by_type
  #   end
  #   full_types_counts_hash = pie_types_hash.values.inject do |memo, order_hash|
  #     memo.merge(order_hash) do |key, old_val, new_val|
  #       old_val + new_val
  #     end
  #   end
  # end
  # ^^^^^^^^^ DUPLICATE OF slices_by_type ^^^^^^^^^ #


  # def total_pies
  # end

  # def get_total_slices
  #   # reference the method of the same name on orders
  #   Order.all.select{|order| order.event_id = self.id}
  #   total_slices = Event.sum(:orders) #.where('orders.event_id = ?', self.id)
  # end

  #### PIZZA LOGIC ####

  def determine_remainder(number)
    if number%8 != 0 && number%8 < 4
      remainder = number % 8
    elsif number%8 != 0 && number%8 >= 4
      remainder = 0
      number += number % 8
    else
      remainder = 0
    end
    num_slices = remainder
    num_pies = number / 8
    return num_slices, num_pies
  end

  def determine_slices_pies
    pie_types_hash = slices_by_type
    pies_slices_hash = {pies: {}, slices: {}}
    pie_types_hash.each_with_object(pies_slices_hash) do |(topping, number), pies_slices_hash|
      num_slices, num_pies = determine_remainder(number)
      # byebug
      pies_slices_hash[:slices][topping] = num_slices unless num_slices == 0
      pies_slices_hash[:pies][topping] = num_pies
    end
  end

  def total_slices_price(slices_hash)
    slices_total = 0
    slices_hash.each do |topping, number|
      pizza = Pizza.find_by_topping(topping)
      slices_total += pizza.indiv_piece_price * number
    end
    slices_total
  end

  def total_pies_price(pies_hash)
    pies_total = 0
    pies_hash.each do |topping, number|
      pizza = Pizza.find_by_topping(topping)
      pies_total += pizza.price * number
    end
    pies_total
  end

  def total_price
    slices_pies = self.determine_slices_pies
    total = 0
    slices_pies.each do |item_type, item_hash|
      # iterate over all of them, find the pizza with that topping
      # add either the pie price or the indiv_piece_price to the total
      if item_type == :pies
        total += total_pies_price(item_hash)
      elsif item_type == :slices
        total += total_slices_price(item_hash)
      end
    end
    total
  end

  #### MAILER ###

  def self.today
    self.all.select do |event|
      event if event.date.day == Time.now.day && event.date.month == Time.now.month
    end
  end

  def self.order_information_admin
    if Event.today.empty? != true
      events = Event.today
      events.each do |event|
        @event = event
        UserMailer.order_information_admin(@event).deliver_now
      end
    end
  end

  def order_information_user
    self.orders.each do |order|
      UserMailer.order_information_user(order).deliver_now
    end
  end

  def date?
    Time.now >= self.deadline && Time.now < self.date
  end

end
