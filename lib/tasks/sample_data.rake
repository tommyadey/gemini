#creates 30 test users
  namespace :db do
    desc "Fill database with sample data"
    task populate: :environment do
      User.create!(fullname: "Example User",
                   email: "example@brackt.com",
                   username: "gemma",
                   password: "gemini")
      29.times do |n|
        fullname  = Faker::Name.name
        email = "other-#{n+1}@brackt.com"
        username = "geno#{n+1}"
        password  = "gemini"
        User.create!(fullname: fullname,
                     email: email,
                     username: username,
                     password: password)
      end
    end
  end