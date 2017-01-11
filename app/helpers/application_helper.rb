module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def panel_title(num)
    case num
    when 'One'
      'ユーザネーム・メールアドレス変更'
    when 'Two'
      '住所登録'
    when 'Three'
      'パスワード変更'
    when 'Four'
      '退会'
    end
  end

  def active_in(n)
    active_in = %w(active in)
    active_in.join(' ') if n == 1
  end
end
