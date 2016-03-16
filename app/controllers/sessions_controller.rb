class SessionsController < ApplicationController
  # login form
  def new
  end

  # login
  def create
    # binding.pry
    @user = User.find_by(email: params[:email])
    session[:user_id] = @user.id
    # binding.pry
    redirect_to events_path
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end


