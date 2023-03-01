require 'rails_helper'

RSpec.describe 'Api::V1::Bookmarks', type: :request do
  describe 'GET /index' do
    let!(:user) { create(:user) }
    let!(:token) { sign_in user }

    context 'ログイン済' do
      it 'ブックマークを全件取得する' do
        create_list(:bookmark, 3, user_id: user.id)
        get '/api/v1/bookmarks', headers: token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['bookmarks'].size).to eq(3)
      end

      it 'ログインユーザーのブックマークを返す' do
        create_list(:bookmark, 3, user_id: user.id)
        get '/api/v1/bookmarks', headers: token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['bookmarks'][0]['user_id']).to eq(user.id)
        expect(JSON.parse(response.body)['bookmarks'][1]['user_id']).to eq(user.id)
        expect(JSON.parse(response.body)['bookmarks'][2]['user_id']).to eq(user.id)
      end
    end

    context '未ログイン' do
      it 'ログインを要求する' do
        create_list(:bookmark, 3, user_id: user.id)
        post '/api/v1/bookmarks'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let!(:new_post) { create(:post) }
    let!(:token) { sign_in user }

    context 'ログイン済' do
      it 'ブックマークを作成する' do
        expect do
          post '/api/v1/bookmarks', params: { user_id: user.id, post_id: new_post.id }, headers: token
        end.to change(Bookmark, :count).by(1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('success')
      end

      it 'パラメータに誤りがある場合はブックマークの作成に失敗する' do
        expect do
          post '/api/v1/bookmarks', params: { user_id: user.id, post_id: nil }, headers: token
        end.not_to change(Bookmark, :count)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('error')
      end
    end

    context '未ログイン' do
      it 'ログインを要求する' do
        post '/api/v1/bookmarks', params: { user_id: user.id, post_id: new_post.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    let!(:new_post) { create(:post) }
    let!(:bookmark) { create(:bookmark, user:, post: new_post) }
    let!(:token) { sign_in user }

    context 'ログイン済' do
      it 'ブックマークを外す' do
        expect do
          delete "/api/v1/bookmarks/#{bookmark.id}", params: { user_id: user.id, post_id: new_post.id }, headers: token
        end.to change(Bookmark, :count).by(-1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('success')
      end
    end

    context '未ログイン' do
      it 'ログインを要求する' do
        delete "/api/v1/bookmarks/#{bookmark.id}", params: { user_id: user.id, post_id: new_post.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
