class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:edit, :update]
  before_action :user_check, except: [:get_area]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(current_user) if current_user == @user
      redirect_to edit_user_url(current_user)
    else
      @user.errors.full_messages.each do |error|
        flash.now[:alert] = error
      end
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

  def set_address
    @addresses = current_user.addresses
  end
end
