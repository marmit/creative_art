namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = Teacher.create!(username: "exampleTeacher",
                    teacher_name: "Example Teacher",
                    password: "Foobar1",
                    password_confirmation: "Foobar1")
    admin.toggle!(:admin)

    99.times do |n|
      username = "InitLastname#{n+1}"
      teacher_name = Faker::Name.name
      password = "Password1"
      Teacher.create!(teacher_name: teacher_name,
                      username: username,
                      password: password,
                      password_confirmation: password)
    end
  end
end
