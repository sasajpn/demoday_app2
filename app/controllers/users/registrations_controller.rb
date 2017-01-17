class Users::RegistrationsController < Devise::RegistrationsController
  layout 'mypage/devise'

  protected

  def after_update_path_for(resource)
    user_url(current_user)
  end
end
