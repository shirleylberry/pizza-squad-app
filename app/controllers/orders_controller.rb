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
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:new, :edit, :input_num_slices, :destroy]

    def index

    end

    def show

    end

    def input_num_slices
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

        UserMailer.welcome_email(current_user).deliver_now


        redirect_to event_order_path(@order.event, @order)
      else
        render :new
      end
    end

    def update
      byebug
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
