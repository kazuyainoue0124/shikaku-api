FactoryBot.define do
  factory :user do
    sequence(:user_name) { |n| "山田太郎#{n}" }
    sequence(:email) { |n| "taro#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
