require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'バリデーションチェック' do
    describe 'ユーザーID(user_id)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, user_id: nil)
          expect(post).to be_invalid
        end
      end
    end

    describe 'タイトル(title)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, title: nil)
          expect(post).to be_invalid
        end
      end

      context '255文字以下の場合' do
        it '登録成功' do
          post = create(:post, title: 'a' * 255)
          expect(post).to be_valid
        end
      end

      context '256文字以上の場合' do
        it '登録失敗' do
          post = build(:post, title: 'a' * 256)
          expect(post).to be_invalid
        end
      end
    end

    describe '資格ID(certificate_id)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, certificate_id: nil)
          expect(post).to be_invalid
        end
      end
    end

    describe '学習期間(study_period)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, study_period: nil)
          expect(post).to be_invalid
        end
      end
    end

    describe '学習方法(how_to_study)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, how_to_study: nil)
          expect(post).to be_invalid
        end
      end
    end

    describe '実務に役立ったか？(valuable_score)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, valuable_score: nil)
          expect(post).to be_invalid
        end
      end
    end

    describe 'どんな人におすすめか？(who_is_recommended)' do
      context '存在しない場合' do
        it '登録失敗' do
          post = build(:post, who_is_recommended: nil)
          expect(post).to be_invalid
        end
      end
    end
  end

  # describe 'ポストモデルのバリデーションチェック' do
  #   let(:user) { create(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'password') }
  #   let(:certificate) { create(:certificate, name: 'ITパスポート') }

  #   context 'データが有効な場合' do
  #     it '全てのカラムの値が存在する' do
  #       post = create(:post, user_id: user.id, title: 'ITパスポートに合格しました!', certificate_id: certificate.id, study_period: 1,
  #         how_to_study: 'ひたすら過去問を解いた', valuable_score: 1, who_is_recommended: nil)
  #       expect(post).to be_valid
  #     end
  #   end
  # end
end
