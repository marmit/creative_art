FactoryGirl.define do
  factory :teacher do
    sequence(:username) { |n| "person#{n}" }
    sequence(:teacher_name) { |n| "Person Is#{n}" }
    password "foobar1"
    password_confirmation "foobar1"

    factory :admin do
      admin true
    end
  end
end
