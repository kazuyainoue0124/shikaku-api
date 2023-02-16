# require 'rails_helper'

# RSpec.describe 'Follows', type: :request do
#   describe '一覧表示' do
#     context '成功する場合' do
#       it 'フォローしているユーザーを全て返す' do
#         # ログイン
#         login(create(:user))

#         create_list(:follow, 10, send_follow_id: current_user.id)

#         get '/follows', params: { send_follow_id: current_user.id }
#         json = JSON.parse(response.body)

#         # リクエスト成功を確認
#         expect(response.status).to eq(200)

#         # データの数が正しいか確認
#         expect(json['follows'].length).to eq(10)
#       end
#     end
#   end

#   describe 'フォローする' do
#     context '成功する場合' do
#       it 'ステータス「success」を返す' do
#         # ログイン
#         login(create(:user))

#         # データの作成を確認
#         expect { post '/follow', params: { send_follow_id: current_user.id, receive_follow_id: create(:user).id } }.to change(Follow, :count).by(+1)
#         json = JSON.parse(response.body)

#         # リクエスト成功を確認
#         expect(response.status).to eq(200)

#         # ステータス「success」を返すことを確認
#         expect(json['status']).to eq('success')
#       end
#     end
#   end

#   describe 'フォローを外す' do
#     context '成功する場合' do
#       it 'ステータス「success」を返す' do
#         # ログイン
#         login(create(:user))

#         follow = create(:follow, send_follow_id: current_user.id)

#         # データの作成を確認
#         expect { post '/unfollow', params: { send_follow_id: current_user.id, receive_follow_id: follow.receive_follow_id } }.to change(Follow, :count).by(-1)
#         json = JSON.parse(response.body)

#         # リクエスト成功を確認
#         expect(response.status).to eq(200)

#         # ステータス「success」を返すことを確認
#         expect(json['status']).to eq('success')
#       end
#     end
#   end
# end
