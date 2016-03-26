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


class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @active_orders = @user.orders.select{|order| order.event.active?}
    @inactive_orders = @user.orders.select{|order| !order.event.active?}
  end

  private

   def set_user
     @user = User.find(params[:id])
   end

   def access_token
    if session[:access_token]
      @access_token ||= OAuth::AccessToken.new(consumer, session[:access_token], session[:access_token_secret])
    end
  end

   def consumer
    @c ||= OAuth::Consumer.new(ENV["SPLITWISE_API_KEY"], ENV["SPLITWISE_API_SECRET"], {
    :site => ENV["SPLITWISE_SITE"],
    :scheme => :header,
    :http_method => :post,
    :authorize_path => ENV["SPLITWISE_AUTHORIZE_URL"],
    :request_token_path => ENV["SPLITWISE_REQUEST_TOKEN_URL"],
    :access_token_path => ENV["SPLITWISE_ACCESS_TOKEN_URL"]
    })
  end

end
