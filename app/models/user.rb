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

  def self.most_slices
    # Slice.select("COUNT(*) as slice_count, users.name").joins(:order => :user).group(:user_id).order("slice_count DESC")
    best_pizza_eaters = User.all.sort { |b, a| a.slices_consumed <=> b.slices_consumed }
    best_pizza_eaters.map { |user| [user.name, user.slices_consumed] }
  end

  def self.most_events
    # Event.select("users.name, COUNT(*) as event_count").joins(:orders => :user).group(:user_id).order("event_count DESC")
    most_pizza_socials = User.all.sort { |b, a| a.events.count <=> b.events.count }
    most_pizza_socials.map { |user| [user.name, user.events.count] }
  end

  def events_attended
    Event.joins(:orders).where(:orders => {user_id: self}).count
  end

  def slices_consumed
    Slice.joins(:order => :user).where(:orders => {user_id: self}).count
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
