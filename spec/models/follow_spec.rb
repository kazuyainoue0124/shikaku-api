require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'バリデーションチェック' do
    describe 'フォローユーザーID(send_follow_id)' do
      context '存在しない場合' do
        it '登録失敗' do
          follow = build(:follow, send_follow_id: nil)
          expect(follow).to be_invalid
        end
      end
    end

    describe 'フォロワーユーザーID(receive_follow_id)' do
      context '存在しない場合' do
        it '登録失敗' do
          follow = build(:follow, receive_follow_id: nil)
          expect(follow).to be_invalid
        end
      end
    end
  end
end
