3.times do |n|
  user = User.new(username:  "#{n}",
                  email: "#{n}@test.com",
                  birthday: "2016-07-24",
                  password: "password",
                  password_confirmation: "password"
                  )
  user.skip_confirmation!
  user.save
end

3.times do |n|
  Book.create(user_id: 1,
           title: "#{n}",
           author: "#{n}",
           condition: 1)
  Book.create(user_id: 1,
           title: "#{n}",
           author: "#{n}",
           condition: 1)
end
