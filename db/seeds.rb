# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "nona",
             email: "nna@nna774.net",
             password:              "foobar",
             password_confirmation: "foobar")

ApiKey.create!(
    access_token: "token",
    expires_at: 20.years.from_now.utc,
    user_id: 1,
    active: true)

99.times do |n|
  name  = "example#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
