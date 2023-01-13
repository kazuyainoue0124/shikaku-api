require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    describe '名前(user_name)' do
      context '存在しない場合' do
        it '登録失敗' do
          user = build(:user, user_name: nil)
          expect(user).to be_invalid
        end
      end

      context '15文字の場合' do
        it '登録成功' do
          user = create(:user, user_name: 'a' * 15)
          expect(user).to be_valid
        end
      end

      context '16文字の場合' do
        it '登録失敗' do
          user = build(:user, user_name: 'a' * 16)
          expect(user).to be_invalid
        end
      end
    end

    describe 'メールアドレス(email)' do
      context '存在しない場合' do
        it '登録失敗' do
          user = build(:user, email: nil)
          expect(user).to be_invalid
        end
      end

      context '正規表現に沿っていない場合' do
        it '登録失敗' do
          user1 = build(:user, email: 'taro@gmail,com')
          user2 = build(:user, email: 'taro_at_foo.org')
          user3 = build(:user, email: 'taro.name@example.')
          user4 = build(:user, email: 'taro@bar_baz.com')
          user5 = build(:user, email: 'taro@bar+baz.com')
          expect(user1).to be_invalid
          expect(user2).to be_invalid
          expect(user3).to be_invalid
          expect(user4).to be_invalid
          expect(user5).to be_invalid
        end
      end

      context '重複している場合' do
        it '登録失敗' do
          user = create(:user, email: 'taro@gmail.com')
          expect(user).to be_valid
          another_user = build(:user, email: 'taro@gmail.com')
          expect(another_user).to be_invalid
        end
      end
    end

    describe 'パスワード(password)' do
      context '存在しない場合' do
        it '登録失敗' do
          user = build(:user, password: nil)
          expect(user).to be_invalid
        end
      end

      context '5文字の場合' do
        it '登録失敗' do
          user = build(:user, password: 'a' * 5, password_confirmation: 'a' * 5)
          expect(user).to be_invalid
        end
      end

      context '6文字の場合' do
        it '登録成功' do
          user = create(:user, password: 'a' * 6, password_confirmation: 'a' * 6)
          expect(user).to be_valid
        end
      end

      context '10文字の場合' do
        it '登録成功' do
          user = create(:user, password: 'a' * 10, password_confirmation: 'a' * 10)
          expect(user).to be_valid
        end
      end

      context '11文字の場合' do
        it '登録失敗' do
          user = build(:user, password: 'a' * 11, password_confirmation: 'a' * 11)
          expect(user).to be_invalid
        end
      end
    end

    describe 'パスワード確認(password_confirmation)' do
      context 'パスワードと不一致の場合' do
        it '登録失敗' do
          user = build(:user, password: 'a' * 8, password_confirmation: 'b' * 8)
          expect(user).to be_invalid
        end
      end
    end
  end
end
