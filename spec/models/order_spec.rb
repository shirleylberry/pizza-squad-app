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

require_relative "../spec_helper.rb"

RSpec.describe Order, type: :model do
  let(:user) {User.create(name: "Lucille Ball", email: "lucille@ilovelucy.com", password: "riiiicky")}
  let(:pres_user) {User.create(name: "Ricky Ricard", email: "ricky@ilovelucy.com", password: "LUUUCY")}
  let(:president) {President.create(user: pres_user)}
  let(:event) {Event.create(date: "2014-09-19 07:03:30 -0700", deadline: "2014-09-19 05:03:30 -0700", title: "PIZZA NOW", description: "YOU HEARD ME", president: president)}
  
  let!(:order) {Order.create(user: user, event: event)}

  let(:no_user_attrs) {{event: event}}
  let(:no_event_attrs) {{user: user}}

  describe 'belongs_to associations' do
    it 'belongs to an event' do
      expect(order.event).to eq(event)
    end

    it 'belongs to a user' do
      expect(order.user).to eq(user)
    end
  end

  describe 'validations' do 
    it 'is invalid without a user' do
      new_order = Order.new(no_user_attrs)
      expect(new_order.save).to eq(false)
    end

    it 'is invalid without an event' do 
      new_order = Order.new(no_event_attrs)
      expect(new_order.save).to eq(false)
    end
  end
end

