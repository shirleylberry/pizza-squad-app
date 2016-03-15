class Order < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :slices
end
