require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーモデルのバリデーションチェック' do
    context 'データが有効な場合' do
      it '名前とメールアドレス、パスワードが存在する' do
        user = create(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end

      it '名前が15文字以内である' do
        user = create(:user, user_name: 'あ' * 15, email: 'taro@example.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end

      it 'パスワードが6文字以上である' do
        user = create(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'a' * 6, password_confirmation: 'a' * 6)
        expect(user).to be_valid
      end

      it 'パスワードが10文字以内である' do
        user = create(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'a' * 10, password_confirmation: 'a' * 10)
        expect(user).to be_valid
      end
    end

    context 'データが無効な場合' do
      it '名前が存在しない' do
        user = build(:user, user_name: nil, email: 'taro@example.com', password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:user_name]).to include('を入力してください')
      end

      it '名前が16文字以上である' do
        user = build(:user, user_name: 'あ' * 16, email: 'taro@example.com', password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:user_name]).to include('は15文字以内で入力してください')
      end

      it 'メールアドレスが存在しない' do
        user = build(:user, user_name: '山田太郎', email: nil, password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end

      it 'メールアドレスが正規表現に沿っていない' do
        user1 = build(:user, user_name: '山田太郎', email: 'taro@gmail,com', password: 'password', password_confirmation: 'password')
        user2 = build(:user, user_name: '山田太郎', email: 'taro_at_foo.org', password: 'password', password_confirmation: 'password')
        user3 = build(:user, user_name: '山田太郎', email: 'taro.name@example.', password: 'password', password_confirmation: 'password')
        user4 = build(:user, user_name: '山田太郎', email: 'taro@bar_baz.com', password: 'password', password_confirmation: 'password')
        user5 = build(:user, user_name: '山田太郎', email: 'taro@bar+baz.com', password: 'password', password_confirmation: 'password')

        expect(user1).not_to be_valid
        expect(user2).not_to be_valid
        expect(user3).not_to be_valid
        expect(user4).not_to be_valid
        expect(user5).not_to be_valid
      end

      it 'メールアドレスが重複している' do
        user = create(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
        another_user = build(:user, user_name: '鈴木太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'password')
        another_user.valid?
        expect(another_user.errors[:email]).to include('はすでに存在します')
      end

      it 'パスワードが5文字以内である' do
        user = build(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'a' * 5, password_confirmation: 'a' * 5)
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end

      it 'パスワードが11文字以上である' do
        user = build(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'a' * 11, password_confirmation: 'a' * 11)
        user.valid?
        expect(user.errors[:password]).to include('は10文字以内で入力してください')
      end

      it 'パスワードとパスワード確認が不一致である' do
        user = build(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'hassworr')
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end
  end
end
