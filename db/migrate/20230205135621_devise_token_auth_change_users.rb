class DeviseTokenAuthChangeUsers < ActiveRecord::Migration[7.0]
  def change
      ## Required
      add_column :users, :provider, :string, null: false, default: "email", comment: "認証方法"
      add_column :users, :uid,      :string, null: false, default: "",      comment: "UID"
      User.reset_column_information
      User.find_each do |user|
          user.update_column(:uid, user.email)
      end
      ## Database authenticatable
      # add_column :users, :email,              :string, null: false, default: ""
      add_column :users, :encrypted_password, :string, null: false, default: ""

      ## Recoverable
      add_column :users, :reset_password_token,   :string
      add_column :users, :reset_password_sent_at, :datetime
      add_column :users, :allow_password_change,  :boolean, default: false, comment: "パスワード変更許可"
      
      ## Rememberable
      add_column :users, :remember_created_at, :datetime
      
      ## Trackable
      add_column :users, :sign_in_count, :integer, default: 0
      add_column :users, :current_sign_in_at, :datetime
      add_column :users, :last_sign_in_at,    :datetime
      add_column :users, :current_sign_in_ip, :string
      add_column :users, :last_sign_in_ip,    :string
      
      ## Confirmable
      add_column :users, :confirmation_token,   :string
      add_column :users, :confirmed_at,         :datetime
      add_column :users, :confirmation_sent_at, :datetime
      add_column :users, :unconfirmed_email,    :string

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
      add_column :users, :profile, :string
      
      ## Tokens
      add_column :users, :tokens, :text, comment: 'トークン'
      
      add_index :users, [:uid, :provider],     unique: true
      add_index :users, :reset_password_token, unique: true
      add_index :users, :confirmation_token,   unique: true
      # add_index :users, :unlock_token,         unique: true
  end
end
