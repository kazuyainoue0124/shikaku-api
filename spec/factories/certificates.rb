FactoryBot.define do
  factory :certificate do
    sequence(:name) { |n| "ITパスポート#{n}" }
  end
end
