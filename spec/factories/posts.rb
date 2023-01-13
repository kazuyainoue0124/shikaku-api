FactoryBot.define do
  factory :post do
    title { '投稿タイトル' }
    study_period { rand(1..13) }
    how_to_study { '学習方法' }
    valuable_score { rand(1..5) }
    who_is_recommended { 'こんな人におすすめ' }
    association :user
    association :certificate
  end
end
