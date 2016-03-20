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

  def slices_by_type
    types_of_slices = Hash.new(0)
    self.slices.each_with_object(types_of_slices) do |slice, types_hash|
      types_hash[slice.pizza.topping] += 1
    end
  end
end
