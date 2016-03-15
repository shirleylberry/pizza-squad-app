class Slice < ActiveRecord::Base
  belongs_to :pizza
  belongs_to :order

  validates :pizza_id, presence: true
  validates :order_id, presence: true
end
