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


  def show

  end



  private

   def set_user
     @user = User.find(params[:id])
   end

end
