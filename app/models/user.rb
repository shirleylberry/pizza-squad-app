# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :orders
  has_many :events, through: :orders
  has_many :slices, through: :orders

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true
end
