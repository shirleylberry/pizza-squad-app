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

require "rspec"
require_relative "../lib/pizzasquad"

RSpec.describe Order, type: :model do
  order1 = Order.create(user_id: "1", event_id: "1")

describe 'belongs_to associations' do
  let(:order) {Order.new}
  let(:event) {Event.new}
  let(:user) {User.new}

    it 'belongs to an event' do
      order.event = event
      expect(order.event).to eq(event)
    end

    it 'belongs to a user' do
      order.user = user
      expect(order.user).to eq(user)
    end

  describe 'attributes' do

    it 'has a user_id' do
      expect(order1.user_id).to eq("1")
    end

    it 'has an event_id' do
      expect(order1.event_id)to eq("1")
    end
  end
end

