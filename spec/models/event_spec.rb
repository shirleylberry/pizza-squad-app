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

require_relative "../spec_helper.rb"

RSpec.describe Event, type: :model do
  let!(:user) {User.create(name: "Jeff Winger", email: "jeff@coollawyer.com", password: "pierceisweird")}
  let!(:pres_user) {User.create(name: "Britta Perry", email: "britta@activism.com", password: "savethewhales")}
  let!(:president) {President.create(user: pres_user)}

  let!(:event) {Event.create(date: "2016-09-19 07:03:30 -0700", deadline: "2016-09-19 05:03:30 -0700", title: "FSP Pizza Party", description: "yum pizza yum", president: president)}

  let(:invalid_date_params) {{date: "2016-09-19 07:03:30 -0700", deadline: "2016-09-10 05:03:30 -0700", title: "FSP Pizza Party", description: "yum pizza yum", president: president}}
  let(:no_title_params) {{date: "2014-09-19 07:03:30 -0700", deadline: "2014-09-19 05:03:30 -0700", description: "yum pizza yum", president: president}}
  let(:no_date_params) {{deadline: "2014-09-19 05:03:30 -0700", title: "FSP Pizza Party", description: "yum pizza yum", president: president}}
  let(:no_deadline_params) {{date: "2014-09-19 07:03:30 -0700", title: "FSP Pizza Party", description: "yum pizza yum", president: president}}
  let(:no_president_params) {{date: "2014-09-19 07:03:30 -0700", deadline: "2014-09-19 05:03:30 -0700", title: "FSP Pizza Party", description: "yum pizza yum"}}

  describe 'attributes' do
    it 'has a president' do
      expect(event.president).to eq(president) # unsure of date format
    end

    it 'has a title' do
      expect(event.title).to eq("FSP Pizza Party")
    end

    it 'has a date' do
      expect(event.date).to eq("2016-09-19 14:03:30.000000000 +0000") # unsure of date format
    end

    it 'has a description' do
      expect(event.description).to eq("yum pizza yum") 
    end

    it 'has a deadline' do
      expect(event.deadline).to eq("2016-09-19 05:03:30 -0700") # same as above - unsure of date format
    end
  end

  describe 'validations' do
    it 'is invalid if the deadline is after the date' do
      invalid_event = Event.new(invalid_date_params)
      expect(invalid_event.save).to eq(false)
    end 

    it 'is invalid without a title' do
      invalid_event = Event.new(no_title_params)
      expect(invalid_event.save).to eq(false)
    end 

    it 'is invalid without a date' do
      invalid_event = Event.new(no_date_params)
      expect(invalid_event.save).to eq(false)
    end 

    it 'is invalid without a deadline' do
      invalid_event = Event.new(no_deadline_params)
      expect(invalid_event.save).to eq(false)
    end 

    it 'is invalid without a president' do
      invalid_event = Event.new(no_president_params)
      expect(invalid_event.save).to eq(false)
    end 
  end

  describe '#determine_slices_pies' do
    it 'splits up the orders into pies and slices' do
      6.times{User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)}
      # byebug
      30.times{Order.create(user: User.all.sample, event: event)}

      @cheese_pizza = Pizza.create(topping: "cheese", price: 17.0)
      @shroom_pizza = Pizza.create(topping: "Mushroom", price: 22.0)
      @pepp_pizza = Pizza.create(topping: "pepperoni", price: 30.0)

      18.times{Slice.create(order: Order.all.sample, pizza: @cheese_pizza)}
      17.times{Slice.create(order: Order.all.sample, pizza: @shroom_pizza)}
      13.times{Slice.create(order: Order.all.sample, pizza: @pepp_pizza)}
      # {"cheese": 18, mushroom: "17", "pepperoni": 13}
      slices_pies = event.determine_slices_pies
      expect(slices_pies).to eq({:pies=>{"cheese"=>2, "Mushroom"=>2, "pepperoni"=>2}, :slices=>{"cheese"=>2, "Mushroom"=>1}})
    end
  end

  # describe '#time_left'
  #   it 'calculates amount of time left before the deadline' do
  #     expect(t).to eq(deadline - DateTime.now)
  #   end 
  # end
end

