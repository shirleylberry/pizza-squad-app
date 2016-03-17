# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def User_mail_preview
    UserMailer.order_confirmation(User.first)
  end

end
