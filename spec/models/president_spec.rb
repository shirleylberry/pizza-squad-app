# == Schema Information
#
# Table name: presidents
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "rspec"
require_relative "../lib/pizzasquad"

RSpec.describe President, type: :model do
  user1 = User.create(user_id: "1")

  describe 'belongs_to associations' do
    let(:president) {President.new}
    let(:user) {User.new}

      it 'belongs to a user' do
        president.user = user
        expect(president.user).to eq(user)
      end

  describe 'attributes' do
    it 'has a user_id' do
      expect(user1.user_id).to eq("1")
    end

end

