class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

    def index

    end

    def show

    end

    def new


      @order = Order.new
      @event = Event.find(params[:event_id])
      @pizzas = Pizza.all

      5.times {@order.slices.build}
    end

    def create
      @order = Order.new(order_params)
      @order.user = current_user
      @order.event = Event.find(params[:event_id])
      if @order.save
        redirect_to event_order_path(@order.event, @order)
      else
        render :new
      end

    end

private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:slices_attributes => [:pizza_id])
  end

end
