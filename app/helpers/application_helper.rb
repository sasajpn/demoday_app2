module ApplicationHelper
  def app_title
    'Re.Book'
  end

  def update_name(num)
    case num
    when 1
      "取引に出す"
    when 4
      "取引の成立を確認する"
    when 5
      '選択したお届け先を知らせる'
    when 6
      "本を配送しましたか？"
    when 7
      "本を受け取りましたか？"
    end
  end

  def update_message(num)
    case num
    when 1
      '1週間は取引が継続されますがよろしいですか？'
    end
  end

  def update_confirm(num)
    case num
    when 1
      '取引に出す'
    end
  end

  def update_cancel(num)
    case num
    when 1
      '取り消す'
    end
  end

  def update_title(num)
    case num
    when 1
      '取引開始の確認'
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
