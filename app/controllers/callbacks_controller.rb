class CallbacksController < Devise::OmniauthCallbacksController
  
  def splitwise
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

end