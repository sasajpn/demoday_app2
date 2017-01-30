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
      '取引は1週間継続されますがよろしいですか？'
    when 4
      'あなたが取引成立を確認したことを相手方にお知らせ致します'
    when 5
      '選択された住所を相手方に通知してもよろしいですか？'
    when 6
      '本の配送をしたかどうかの再確認です'
    when 7
      '本を受け取ったかどうかの再確認です'
    end
  end

  def update_confirm(num)
    case num
    when 1
      '取引に出す'
    when 4
      '確認'
    when 5
      '通知する'
    when 6
      '配送した'
    when 7
      '受け取った'
    end
  end

  def update_cancel(num)
    case num
    when 1, 4, 5
      '取り消す'
    when 6
      'まだ配送していない'
    when 7
      'まだ受け取っていない'
    end
  end

  def update_title(num)
    case num
    when 1
      '取引開始の確認'
    when 4
      '取引成立の確認'
    when 5
      'お届け先通知の確認'
    when 6
      '本の配送の再確認'
    when 7
      '本の受け取りの再確認'
    end
  end

  def trade_progress(obj_s, other_s)
    case
    when obj_s == 3 && other_s == 3
      '取引成立の確認 - 0%'
    when obj_s == 3 && other_s == 4 || obj_s == 4 && other_s == 3
      '取引成立の確認 - 10%'
    when obj_s == 4 && other_s == 4
      '住所の通知 - 20%'
    when obj_s == 4 && other_s == 5 || obj_s == 5 && other_s == 4
      '住所の通知 - 30%'
    when obj_s == 5 && other_s == 5
      '本の配送 - 40%'
    when obj_s == 5 && other_s == 6 || obj_s == 6 && other_s == 5
      '本の配送 - 50%'
    when obj_s == 6 && other_s == 6
      '本の受け取り - 60%'
    when obj_s == 6 && other_s == 7 || obj_s == 7 && other_s == 6
      '本の受け取り - 70%'
    when obj_s == 7 && other_s == 7
      '取引相手の評価 - 80%'
    when obj_s == 7 && other_s == 8 || obj_s == 8 && other_s == 7
      '取引相手の評価 - 90%'
    when obj_s == 8 && other_s == 8
      '取引相手の評価 - 100%'
    end
  end

  def progress_bar(obj_s, other_s)
    case
    when obj_s == 3 && other_s == 3
      '0'
    when obj_s == 3 && other_s == 4 || obj_s == 4 && other_s == 3
      '10'
    when obj_s == 4 && other_s == 4
      '20'
    when obj_s == 4 && other_s == 5 || obj_s == 5 && other_s == 4
      '30'
    when obj_s == 5 && other_s == 5
      '40'
    when obj_s == 5 && other_s == 6 || obj_s == 6 && other_s == 5
      '50'
    when obj_s == 6 && other_s == 6
      '60'
    when obj_s == 6 && other_s == 7 || obj_s == 7 && other_s == 6
      '70'
    when obj_s == 7 && other_s == 7
      '80'
    when obj_s == 7 && other_s == 8 || obj_s == 8 && other_s == 7
      '90'
    when obj_s == 8 && other_s == 8
      '100'
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
