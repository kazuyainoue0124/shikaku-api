require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーションチェック' do
    describe 'ユーザーID(user_id)' do
      context '存在しない場合' do
        it '登録失敗' do
          bookmark = build(:bookmark, user_id: nil)
          expect(bookmark).to be_invalid
        end
      end
    end

    describe '投稿ID(post_id)' do
      context '存在しない場合' do
        it '登録失敗' do
          bookmark = build(:bookmark, post_id: nil)
          expect(bookmark).to be_invalid
        end
      end
    end
  end
end
