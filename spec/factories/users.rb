# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:uid) { |n| "MyString#{n}" }
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:email) { |n| "test#{n}@test.test" }
  end
end
