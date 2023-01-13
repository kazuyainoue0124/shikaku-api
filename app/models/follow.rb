class Follow < ApplicationRecord
  belongs_to :send_follow_user, class_name: 'User', foreign_key: :send_follow_id, inverse_of: 'send_follow_users'
  belongs_to :receive_follow_user, class_name: 'User', foreign_key: :receive_follow_id, inverse_of: 'receive_follow_users'

  validates :send_follow_id, presence: true, uniqueness: { scope: :receive_follow_id }
  validates :receive_follow_id, presence: true
end
