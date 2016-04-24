# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :slices

  validates :user_id, presence: true
  validates :event_id, presence: true
  accepts_nested_attributes_for :slices

  def total_slices
    self.slices.count
  end

  def price
    ((self.event.total_price / self.event.slices.count) * self.slices.count).round(2)
  end

  def slices_by_type
    Slice.joins(:order, :pizza).where("orders.id = ?", self).group("pizzas.topping").count
  end

  def self.total_slices_per_order
    self.all.map{|order| order.slices.count}
  end
  #=> [9, 7, 25]

  def self.average_num_slices
    (total_slices_per_order.inject(0) { |sum, num_slices| sum + num_slices } / self.all.size.to_f ).round(2)
  end
end
