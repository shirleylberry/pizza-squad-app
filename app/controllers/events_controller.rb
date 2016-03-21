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

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]


  def index
    @events = Event.all
    @active_events = Event.active_events
  end

  def show
    @orders = @event.orders
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.president = President.create(user: current_user)

    if @event.save
      redirect_to event_path @event
    else
      render :new
    end
  end

  def edit
    redirect_to @event if @event.president.user != current_user
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def user_order_email
    @event = Event.find(params[:event_id])
    @event.order_information_user
    redirect_to event_path @event
  end



  private

   def set_event
     @event = Event.find(params[:id])
   end

   def event_params
    params.require(:event).permit(:title, :description, :date, :deadline, :restaurant_id)
   end


end
