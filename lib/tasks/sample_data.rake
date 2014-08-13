namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Taha Husain",
                 email: "taha@example.com",
                 password: "fedora",
                 password_confirmation: "fedora")
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "redhat",
                 password_confirmation: "redhat")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "google"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    admin = User.create!(name: "Admin User",
                         email: "admin@example.com",
                         password: "password",
                         password_confirmation: "password",
                         admin: true)
  end
end