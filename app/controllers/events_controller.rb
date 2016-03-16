class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @orders = @event.orders
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.president = President.new(user: current_user)

    if @event.save
      redirect_to event_path @event
    else
      render :new
    end
  end



  private

   def set_event
     @event = Event.find(params[:id])
   end

   def event_params
    params.require(:event).permit(:title, :description, :date, :deadline)
   end


end
