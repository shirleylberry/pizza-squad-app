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

  # pizza logic
  def determine_remainder(number)
    if number%8 != 0 && number%8 < 4
      remainder = number % 8
    elsif number%8 != 0 && number%8 >= 4
      remainder = 0
      number += number % 8
    end
    num_slices = remainder
    num_pies = number / 8
    return num_slices, num_pies
  end
  
  def determine_slices_pies
    pie_types_hash = get_pie_types_counts_hash
    # # byebug
    pies_slices_hash = {pies: {}, slices: {}}
    order_hash = pie_types_hash.each_with_object(pies_slices_hash) do |(topping, number), pies_slices_hash|
      num_slices, num_pies = determine_remainder(number)
      pies_slices_hash[:slices][topping] = num_slices unless num_slices == 0
      pies_slices_hash[:pies][topping] = num_pies
    end
  end

  def get_pie_types_counts_hash
    # byebug
    # pie_types = {"cheese": 10, "mushroom": 4, "pepperoni": 15}
    pie_types_hash = self.orders.each_with_object({}) do |order, orders_hash|
      orders_hash[order.id] = Slice.get_num_slices_per_order(order)
    end
    full_types_counts_hash = pie_types_hash.values.inject do |memo, order_hash|
      memo.merge(order_hash) do |key, old_val, new_val|
        old_val + new_val
      end
    end
  end

end
