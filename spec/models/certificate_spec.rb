require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe 'バリデーションチェック' do
    describe '名前(name)' do
      context '存在しない場合' do
        it '登録失敗' do
          certificate = build(:certificate, name: nil)
          expect(certificate).to be_invalid
        end
      end

      context '50文字以下の場合' do
        it '登録成功' do
          certificate = create(:certificate, name: 'a' * 50)
          expect(certificate).to be_valid
        end
      end

      context '51文字以上の場合' do
        it '登録失敗' do
          certificate = build(:certificate, name: 'a' * 51)
          expect(certificate).to be_invalid
        end
      end

      context '重複している場合' do
        it '登録失敗' do
          certificate = create(:certificate)
          expect(certificate).to be_valid
          another_certificate = build(:certificate, name: certificate.name)
          expect(another_certificate).to be_invalid
        end
      end
    end
  end
  # describe '資格モデルのバリデーションチェック' do
  #   context 'データが有効な場合' do
  #     it '名前が存在する' do
  #       certificate = create(:certificate, name: 'ITパスポート')
  #       expect(certificate).to be_valid
  #     end

  #     it '名前が50文字以下である' do
  #       certificate = create(:certificate, name: 'a' * 50)
  #       expect(certificate).to be_valid
  #     end
  #   end

  #   context 'データが無効な場合' do
  #     it '名前が存在しない' do
  #       certificate = build(:certificate, name: nil)
  #       certificate.valid?
  #       expect(certificate.errors[:name]).to include('を入力してください')
  #     end

  #     it '名前が51文字以上である' do
  #       certificate = build(:certificate, name: 'a' * 51)
  #       certificate.valid?
  #       expect(certificate.errors[:name]).to include('は50文字以内で入力してください')
  #     end

  #     it '名前が重複している' do
  #       certificate = create(:certificate, name: 'ITパスポート')
  #       another_certificate = build(:certificate, name: 'ITパスポート')
  #       another_certificate.valid?
  #       expect(another_certificate.errors[:name]).to include('はすでに存在します')
  #     end
  #   end
  # end
end
