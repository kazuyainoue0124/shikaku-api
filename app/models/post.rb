class Post < ApplicationRecord
  belongs_to :user
  belongs_to :certificate
  has_many :bookmarks, dependent: :destroy

  # デフォルトの順序を降順に変更
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :certificate_id, presence: true
  validates :study_period, presence: true
  validates :how_to_study, presence: true
  validates :valuable_score, presence: true
  validates :who_is_recommended, presence: true
end
