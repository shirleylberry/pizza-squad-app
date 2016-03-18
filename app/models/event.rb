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

  validates :president_id, presence: true
  validates :title, presence: true
  validates :date, presence: true
  validates :deadline, presence: true
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
    mm, ss = t.divmod(60)            #=> [4515, 21]
    hh, mm = mm.divmod(60)           #=> [75, 15]
    dd, hh = hh.divmod(24)           #=> [3, 3]
    "%d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
  end

  def active
    Time.now > self.date ? false : true
  end

  #### ORDERING FUNCTIONALITY ####

  # def get_total_slices
  #   # reference the method of the same name on orders
  #   Order.all.select{|order| order.event_id = self.id}
  #   total_slices = Event.sum(:orders) #.where('orders.event_id = ?', self.id)
  # end

  def get_pie_types_counts_hash
    # pie_types = {"cheese": 10, "mushroom": 4, "pepperoni": 3}
    pie_types_hash = self.orders.each_with_object({}) do |order, orders_hash|
      orders_hash[order.id] = Slice.get_num_slices_per_order(order)
    end
    full_types_counts_hash = pie_types_hash.values.inject do |memo, order_hash|
      memo.merge(order_hash) do |key, old_val, new_val|
        old_val + new_val
      end
    end
  end

  # def total_pies
  # end

  def self.todays_events
    self.all.select do |event|
      event if event.date.day == Time.now.day && event.date.month == Time.now.month
    end
  end

  def self.event_reminder
    if Event.todays_events.empty? != true
      events = Event.todays_events
      events.each do |event|
        @event = event
        UserMailer.order_information(@event).deliver_now
      end
    end
  end

  #### ANALYTICS ####

  def self.average_event_cost
  end

end
