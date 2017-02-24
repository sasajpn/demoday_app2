class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  # before_action :user_check, except: [:top, :info, :contact], unless: :devise_controller?
  # before_action :user_book_check, except: [:top, :info, :contact], unless: :devise_controller?

  private

  def configure_permitted_parameters
    added_attrs = [:username, :email, :birthday, :icon, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  def user_check
    @user = User.find_by(id: params[:user_id]) || User.find_by(id: params[:id])
    unless current_user == @user
      redirect_to user_url(current_user), notice: "そのページはご利用いだだけません"
    end
  end

  def user_book_check
    @book = Book.find_by(id: params[:book_id]) || Book.find_by(id: params[:id])
    @user = @book.user
    unless current_user == @user
      redirect_to user_url(current_user), notice: "そのページはご利用いだだけません"
    end
  end
end
