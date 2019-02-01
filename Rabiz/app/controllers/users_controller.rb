class UsersController < ApplicationController 
  def new 
    :new
  end

  def show 
    @user = User.find_by(id: params[:id])
  end

  def create 
    user = User.new(user_params)

    if user.save! 
       render json: "COOL"
    else 
       render json: user.errors.full_messages
    end
  end

  private 
  def user_params 
   params.require(:user).permit(:email, :password)
  end
end