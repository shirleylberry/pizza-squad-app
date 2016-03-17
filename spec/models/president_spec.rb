# == Schema Information
#
# Table name: presidents
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require_relative "../spec_helper.rb"

RSpec.describe President, type: :model do
  let(:user) {User.create(name: "President Bartlet", email: "martin@sheen.com", password: "ilovewestwing")}
  let!(:president) {President.create(user: user)}

  describe 'belongs_to associations' do
    it 'belongs to a user' do
      president.user = user
      expect(president.user).to eq(user)
    end
  end

  describe 'validations' do
    it 'is invalid without a user' do
      invalid_pres = President.new
      expect(invalid_pres.save).to eq(false)
    end
  end
end

