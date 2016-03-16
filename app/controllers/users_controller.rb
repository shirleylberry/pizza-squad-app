class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def show
    # @orders = @user.orders
    @active_orders = @user.orders.select{|order| order.event.active}
    @inactive_orders = @user.orders.select{|order| !order.event.active}
  end



  private

   def set_user
     @user = User.find(params[:id])
   end

end
