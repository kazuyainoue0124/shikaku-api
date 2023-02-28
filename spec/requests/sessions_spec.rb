# require 'rails_helper'

# RSpec.describe 'Sessions', type: :request do
#   before do
#     create(:user, user_name: '山田太郎', email: 'taro@example.com', password: 'password', password_confirmation: 'password')
#     post '/login', params: { email: 'taro@example.com', password: 'password' }
#   end

#   describe 'ログイン' do
#     context '成功する場合' do
#       it 'ステータスコード200を返す' do
#         expect(response.status).to eq(200)
#       end

#       it 'セッションにユーザーIDを保存する' do
#         expect(logged_in?).to be_truthy
#       end

#       it 'ログインしたユーザーのデータを返す' do
#         json = JSON.parse(response.body)
#         expect(json['user']['user_name']).to eq('山田太郎')
#         expect(json['user']['email']).to eq('taro@example.com')
#       end
#     end
#   end

#   describe 'ログアウト' do
#     context '成功する場合' do
#       before do
#         delete '/logout'
#       end

#       it 'ステータスコード200を返す' do
#         expect(response.status).to eq(200)
#       end

#       it 'セッションのユーザーIDを削除する' do
#         expect(logged_in?).to_not be_truthy
#       end
#     end
#   end
# end
