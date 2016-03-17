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

require_relative "../spec_helper.rb"

RSpec.describe User, type: :model do
  let!(:user1) { User.create(name: "Nikola Tesla", email: "ntesla@teslacars.com", password: "ImmaBoss") }
  let!(:duplicate_user) { User.new(name: "Thomas Edison", email: "ntesla@teslacars.com", password: "nikolaistheworst") }
  let(:no_email_attributes) { {name: "Thomas Edison", password: "itselectric"} }
  let(:no_password_attributes) { {name: "Thomas Edison", email: "thomas@edison.com"} }

  describe 'attributes' do
    it 'has a name' do
      expect(user1.name).to eq("Nikola Tesla")
    end

    it 'has an email' do
      expect(user1.email).to eq("ntesla@teslacars.com") 
    end

    it 'has a password' do
      expect(user1.password).to eq("ImmaBoss") 
    end
  end

  describe 'validations' do
    it 'is invalid with a duplicate email' do
      expect(duplicate_user.save).to be(false)
    end

    it 'is invalid without an email' do
      no_email_user = User.new(no_email_attributes)
      expect(no_email_user.save).to be(false)
    end

    it 'is invalid without a password' do
      no_password_user = User.new(no_password_attributes)
      expect(no_password_user.save).to be(false)
    end
  end
end

