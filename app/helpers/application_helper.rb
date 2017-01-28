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

  def app_title
    'Re.Book'
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

  def get_evaluatee(parent, child)
    return child.user if current_user == parent.user
    return parent.user if current_user == child.user
  end

  def step_content(num)
    return "次のStepに進んでください！" if num >= 3 && num <= 5
    return "これで取引は終了です！" if num == 6
    return "引き続き弊サービスをよろしくお願い致します！" if num == 7
  end

  def which_collection(books, n)
    case n
    when 1
      return books.where(status: 0)
    when 2
      return books.where(status: 1)
    when 3
      return Book.where(id: Negotiate.where(child_id: books).select(:parent_id))
    when 4
      return books.where(status: [3, 4, 5, 6])
    when 5
      return books.where(status: [7, 8])
    end
  end

  def update_title(num)
    case num
    when 1
      "取引に出す"
    when 4
      "取引の成立を確認する"
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

  def finish_eval(object)
    "取引相手の評価は終了しています" if object.status == 8
  end

  def icon(animal)
    case
    when animal.include?("チーター")
      'Cheetah.png'
    when animal.include?("たぬき")
      'Raccoon.png'
    when animal.include?("猿")
      'Monkey.png'
    when animal.include?("コアラ")
      'Koala.png'
    when animal.include?("黒ひょう")
      'Leopard.png'
    when animal.include?("虎")
      'Tiger.png'
    when animal.include?("こじか")
      'Deer.png'
    when animal.include?("ゾウ")
      'Elephant.png'
    when animal.include?("狼")
      'Wolf.png'
    when animal.include?("ひつじ")
      'Sheep.png'
    when animal.include?("ペガサス")
      'Pegasus.jpg'
    when animal.include?("ライオン")
      'Lion.png'
    end
  end

  def icon_style(animal)
    case
    when animal.include?("チーター")
      'cheetah'
    when animal.include?("たぬき")
      'raccoon'
    when animal.include?("猿")
      'monkey'
    when animal.include?("コアラ")
      'koala'
    when animal.include?("黒ひょう")
      'leopard'
    when animal.include?("虎")
      'tiger'
    when animal.include?("こじか")
      'deer'
    when animal.include?("ゾウ")
      'elephant'
    when animal.include?("狼")
      'wolf'
    when animal.include?("ひつじ")
      'sheep'
    when animal.include?("ペガサス")
      'pegasus'
    when animal.include?("ライオン")
      'lion'
    end
  end

  def confirm_message(num)
    case num
    when 1
      '取引に出すと、1週間はこの本を使って他のユーザの取引に交渉できなくなりますがよろしいですか？'
    end
  end

  def set_active(negotiate, n)
    parent = negotiate.parent_status
    child = negotiate.child_status
    if parent == n && child == n
      style = 'active'
    elsif (parent - 1) == n && child == n
      style = 'active'
    elsif parent == n && (child - 1) == n
      style = 'active'
    end
    style
  end

  def set_address(user, negotiate)
    if user == negotiate.parent_user
      return negotiate.parent.book_address.address
    else
      return negotiate.child.book_address.address
    end
  end
end
