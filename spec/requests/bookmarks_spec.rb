require 'rails_helper'

RSpec.describe 'Bookmarks', type: :request do
  describe '一覧表示' do
    context '成功する場合' do
      it 'ブックマークした全ての投稿を返す' do
        # ログイン
        login(create(:user))

        create_list(:bookmark, 10, user_id: current_user.id)

        get '/bookmarks', params: { user_id: current_user.id }
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # データの数が正しいか確認
        expect(json['bookmarks'].length).to eq(10)
      end
    end
  end

  describe 'ブックマークする' do
    context '成功する場合' do
      it 'ステータス「success」を返す' do
        # ログイン
        login(create(:user))

        # データの作成を確認
        expect { post '/bookmark', params: { user_id: current_user.id, post_id: create(:post).id } }.to change(Bookmark, :count).by(+1)
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # ステータス「success」を返すことを確認
        expect(json['status']).to eq('success')
      end
    end
  end

  describe 'ブックマークを外す' do
    context '成功する場合' do
      it 'ステータス「success」を返す' do
        # ログイン
        login(create(:user))

        bookmark = create(:bookmark, user_id: current_user.id)

        # データの作成を確認
        expect { post '/unbookmark', params: { user_id: current_user.id, post_id: bookmark.post_id } }.to change(Bookmark, :count).by(-1)
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # ステータス「success」を返すことを確認
        expect(json['status']).to eq('success')
      end
    end
  end
end
