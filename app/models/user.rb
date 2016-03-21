# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  password               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :events, through: :orders
  has_many :slices, through: :orders

  #### ANALYTICS ####

  # GROUP

  def self.sorted_by_slice_count
      User.joins(:slices).group(:user_id).order("COUNT(slices.id) DESC")
    # <ActiveRecord::Relation [#<User id: ...>, #<User id: ...>, ...]>
  end

  def self.users_with_slice_count
    self.sorted_by_slice_count.pluck("users.name, COUNT(slices.id)")
    # => [["Anna Nigma", 9], ["Georgianna Schimmel", 7], ["Sammy Mernick", 6], ["Janie Gleichner", 4]]
  end

  def self.sorted_by_event_count
    User.joins(:events).group(:user_id).order("COUNT(events.id) DESC")
  end

  def self.users_with_event_count
    self.sorted_by_event_count.pluck("users.name, COUNT(events.id)")
  end

  # INDIVIDUAL

  def events_attended
    Event.joins(:orders).where(:orders => {user_id: self}).count
  end

  def slices_consumed
    Slice.joins(:order => :user).where(:orders => {user_id: self}).count
  end

  def slices_consumed_by_type
    Pizza.joins(:slices).where(:orders => {user_id: self}).group(:topping).order("COUNT(slices.id) DESC")
  end

  def total_consumed
    "You've eaten #{whole_pizzas_consumed} pizzas and #{slice_remainders_consumed} slices."
  end

  def whole_pizzas_consumed
    slices_consumed / 8
  end

  def slice_remainders_consumed
    slices_consumed % 8
  end

  def calories_consumed
    slices_consumed * 272
  end

  def miles_needed_to_walk
    calories_consumed / 100
  end

end
