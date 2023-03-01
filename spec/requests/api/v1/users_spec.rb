require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /show' do
    let!(:user1) { create(:user, id: 1) }
    let!(:user2) { create(:user, id: 2) }
    let!(:token) { sign_in user1 }

    context 'ログイン済' do
      it '指定したユーザーが返ってくる' do
        get "/api/v1/users/#{user2.id}", params: { id: user2.id }, headers: token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['user']['id']).to eq(user2.id)
      end

      it '指定したユーザーが存在しない場合、エラーメッセージを返す' do
        get '/api/v1/users/8', params: { id: 8 }, headers: token
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('ユーザーが見つかりませんでした')
      end
    end

    context '未ログイン' do
      it 'ログインを要求する' do
        get "/api/v1/users/#{user2.id}", params: { id: user2.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
