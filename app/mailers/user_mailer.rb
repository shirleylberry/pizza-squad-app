class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Order Placed - 'Za Squad")
  end


  def order_confirmation(user, order)
    @user = user
    @order = order
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Order Placed - 'Za Squad")

  end

  def order_information_admin(event)
    @event = event
    mail(to: @event.president.user.email, subject: "It's Pizza Time")
  end


  def order_information_user(order)
    @order = order
    mail(to: @order.user.email, subject: 'Order/Payment Details - #{@order.event.title}')
  end

end
