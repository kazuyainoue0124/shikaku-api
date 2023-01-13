class Certificate < ApplicationRecord
  has_many :posts, dependent: :restrict_with_error

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
