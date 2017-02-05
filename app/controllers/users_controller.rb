class UsersController < ApplicationController
  before_action :set_address, only: [:edit, :update]

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
    @address = current_user.address
  end
end
