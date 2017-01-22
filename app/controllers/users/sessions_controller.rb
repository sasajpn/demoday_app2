class Users::SessionsController < Devise::SessionsController
  layout 'mypage/devise'

  def after_sign_in_path_for(resource)
    user_url(current_user)
  end

  def after_sign_out_path_for(resource)
    root_url
  end
end
