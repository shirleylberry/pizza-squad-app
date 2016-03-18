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

  def self.most_presidential
    # President.select("COUNT(events.id) as event_count").joins(:events).where(:president_id => self).order("event_count")
    most_presidential = User.all.sort { |b, a| a.events.count <=> b.events.count }
    most_presidential.map { |user| [user.name, user.events.count] }
  end

  def events_hosted
    Event.joins(:president).where(:president_id => self).count
  end
end
