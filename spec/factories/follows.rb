FactoryBot.define do
  factory :follow do
    association :send_follow_user,
                factory: :user
    association :receive_follow_user,
                factory: :user
  end
end
