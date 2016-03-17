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
end
