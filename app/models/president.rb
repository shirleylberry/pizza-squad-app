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
end
