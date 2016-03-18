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

  # VALIDATIONS

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

end
