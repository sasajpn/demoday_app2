module AssignAnimal
  extend ActiveSupport::Concern

  def leap_year(year)
    if year % 400 == 0
      true
    elsif year % 100 == 0
      false
    elsif year % 4 == 0
      true
    end
  end

  def original_num
    OriginalNumber.find(birthday.month).num
  end

  def calculate_from_year_and_month
    count = original_num
    (1921..birthday.year).each do |y|
      if leap_year(y) == true && !(birthday.month == 1 || birthday.month == 2)
        count += 6
      elsif leap_year(y - 1) == true && (birthday.month == 1 || birthday.month == 2)
        count += 6
      else
        count += 5
      end
      count -= 60 if count >= 60
    end
    count
  end

  def plus_day
    result = calculate_from_year_and_month + birthday.day
    result - 60 if result > 60
  end

  def set_animal
    Animal.find(plus_day).id
  end
end
