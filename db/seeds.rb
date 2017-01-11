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
