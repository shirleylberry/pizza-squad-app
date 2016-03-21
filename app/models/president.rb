# == Schema Information
#
# Table name: presidents
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class President < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates :user_id, presence: true

  #### ANALYTICS ####

  # GROUP

  def self.sorted_by_event_count
    President.joins(:events, :user).group(:user_id).order("COUNT(events.id)")
  end

  def self.presidents_with_event_count
    self.sorted_by_event_count.pluck("users.name, COUNT(events.id)")
  end

  # INDIVIDUAL

  def events_hosted
    Event.joins(:president).where(:president_id => self).count
  end

  def num_participants_per_event
    self.events.map { |event| event.users.count }
  end

  def average_num_participants
    (num_participants_per_event.inject(0) { |sum, num_participants| sum + num_participants } / self.events.size ).round(2)
  end

  def num_slices_per_event
    self.events.map do |event|
      event.orders.inject(0) { |sum, order| sum + order.slices.count }
    end
  end

  def average_num_slices
    (num_slices_per_event.inject(0) { |sum, num_slices| sum + num_slices } / self.events.size ).round(2)
  end
end
