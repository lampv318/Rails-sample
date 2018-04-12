User.create! name:  "lampv",
  email: "lampv@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name,
   email: email,
   password: password,
   password_confirmation: password
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
