class Order < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :slices

  validates :user_id, presence: true
  validates :event_id, presence: true
end
