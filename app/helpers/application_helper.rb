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

  def which_status(n)
    case n
    when 1
      return 0
    when 2
      return 1
    when 3
      return 2
    when 4
      return [3, 4, 5, 6]
    when 5
      return [7, 8]
    end
  end

  def update_title(num)
    case num
    when 1
      "取引に出す"
    when 4
      "取引の成立を確認する"
    when 5
      "選択した住所を通知する"
    when 6
      "本を配送しましたか？"
    when 7
      "本を受け取りましたか？"
    end
  end

  def new_or_edit
    case controller.action_name
    when 'new'
      'お届け先の登録'
    when 'edit'
      'お届け先の変更'
    end
  end
end
