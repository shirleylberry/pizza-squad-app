# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

    # def new
    #   @user = User.new
    #   render file: "app/views/users/registrations/new.html.erb"
    # end

  def show
    @active_orders = @user.orders.select{|order| order.event.active}
    @inactive_orders = @user.orders.select{|order| !order.event.active}
  end

  private

   def set_user
     @user = User.find(params[:id])
   end

end
