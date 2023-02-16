class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :posts, dependent: :destroy

  has_many :bookmarks, dependent: :destroy

  has_many :active_follows, class_name: 'Follow', foreign_key: :send_follow_id, dependent: :destroy, inverse_of: 'send_follow_user'
  has_many :passive_follows, class_name: 'Follow', foreign_key: :receive_follow_id, dependent: :destroy, inverse_of: 'receive_follow_user'
  has_many :receive_follow_users, through: :active_follows, source: :receive_follow_user # 自分がフォローしたユーザー
  has_many :send_follow_users, through: :passive_follows, source: :send_follow_user # 自分をフォローしたユーザー

  validates :user_name, presence: true, length: { maximum: 15 }

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  #   has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 10 }, allow_nil: true
end
