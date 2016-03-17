class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end


  # def order_confirmation(user)
  #   @user = user
  #   mail(to: user.email, subject: 'Registered')
  # end

end
