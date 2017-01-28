class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_check, except: [:get_area]

  def show
  end
  
  def edit
    @addresses = current_user.addresses
  end

  def update
    if @user.update(user_params)
      sign_in(@user, bypass: true) if current_user == @user
      redirect_to user_url(current_user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
