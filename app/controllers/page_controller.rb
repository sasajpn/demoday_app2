class PageController < ApplicationController
  def top
    if user_signed_in?
      redirect_to user_url(current_user)
    else
      render layout: 'mypage/top'
    end
  end

  def info
  end

  def contact
  end
end
