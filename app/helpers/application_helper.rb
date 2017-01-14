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

  def parent_or_child(parent, child)
    return parent if current_user == parent.user
    return child if current_user == child.user
  end

  def step_content(num)
    return "次のStepに進んでください！" if num >= 3 && num <= 5
    return "これで取引は終了です！" if num >= 6
  end
end
