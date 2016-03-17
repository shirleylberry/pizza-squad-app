# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  date         :datetime
#  title        :string
#  description  :text
#  deadline     :datetime
#  president_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "rspec"
require_relative "../lib/pizzasquad"

RSpec.describe Event, type: :model do
  # let(:event) {Event.new}
  # let(:user) {User.create(name: "Shirley", email: "shirley@gmail.com")}
  # let(:president) {President.new}
  describe 'belongs_to associations' do
      it 'belongs to a president' do
        Event.president = president
        expect(event.president).to eq(president)
      end
    end
    e1 = Event.create(title: "FSP Pizza Party", description: "yum pizza yum")

    describe 'attributes' do
      it 'has a title' do
        expect(e1.title).to eq("FSP Pizza Party")
      end

      it 'has a date' do
        e1.date = 
        expect(e1.date).to eq("") # unsure of date format
      end

      it 'has a description' do
        e1.description = "yum pizza yum"
        expect(e1.description).to eq("yum pizza yum") 
      end

      it 'has a deadline' do
        e1.deadline = 
        expect(Event.first.name).to eq("") # same as above - unsure of date format
      end

      it 'has a president' do
        e1.pres_id = "1"
        expect(Event.first.pres_id).to eq('1')
      end

  # describe 'instance methods' do
      it 'makes sure the deadline comes before than the date' do
        e1.deadline_before_date
        expect("")
      end 

    describe 'time_left'
      it 'calculates amount of time left before the deadline' do
        expect(t).to eq(deadline - DateTime.now)
      end 
end

