require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'ユーザーの新規登録が成功する場合' do
    it 'DBにユーザーが1件追加され、ステータスコード200と登録したユーザーのデータを返す' do
      user_params = { user_name: '山田太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'password' }

      # データの作成を確認
      expect { post '/signup', params: user_params }.to change(User, :count).by(+1)
      json = JSON.parse(response.body)

      # リクエスト成功を確認
      expect(response.status).to eq(200)

      # 登録したユーザーのデータを返すことを確認
      expect(json['user']['user_name']).to eq('山田太郎')
      expect(json['user']['email']).to eq('taro@example.com')
    end
  end
end
