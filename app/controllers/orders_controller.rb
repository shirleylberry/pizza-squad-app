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

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :add_slice]
  before_action :set_event, only: [:new, :edit, :show, :destroy, :input_num_slices, :add_slice]

    def index

    end

    def show
      @slices_by_type = @order.slices_by_type
    end

    def input_num_slices
    end

    def add_slice
      @pizzas = Pizza.all
      @order.slices.build
      render :edit
    end

    def new
      @order = Order.new
      @pizzas = Pizza.all
      num_slices = params[:num_slices].to_i
      num_slices.times {@order.slices.build}
    end

    def edit
      @pizzas = Pizza.all
    end

    def create
      @order = Order.new(order_params)
      @order.user = current_user
      @order.event = Event.find(params[:event_id])
      if @order.save
        UserMailer.order_confirmation(current_user, @order).deliver_now
        redirect_to event_order_path(@order.event, @order)
      else
        render :new
      end
    end

    def update
      if @order.update(order_params)
        redirect_to event_order_path(@order.event, @order)
      else
        render :edit
      end
    end

    def destroy
      @order.destroy
      redirect_to @event
    end

private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def order_params
    params.require(:order).permit(:slices_attributes => [:pizza_id, :id])
  end

end
