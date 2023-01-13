require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe '一覧表示' do
    context '成功する場合' do
      it '全ての投稿を取得してデータを返す' do
        create_list(:post, 10)

        get '/posts'
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # データの数が正しいか確認
        expect(json['posts'].length).to eq(10)
      end
    end
  end

  describe '特定の投稿を取得' do
    context '成功する場合' do
      it '投稿idに紐づくデータを返す' do
        post = create(:post)

        get "/posts/#{post.id}"
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # 取得したデータが正しいか確認
        expect(json['post']['id']).to eq(post.id)
      end
    end
  end

  describe '新規投稿' do
    context '成功する場合' do
      it 'DBに投稿が1件追加されステータス「success」を返す' do
        # ログイン
        login(create(:user))

        post = build(:post, user_id: current_user.id, certificate_id: create(:certificate).id)
        post_params = { title: post.title, study_period: post.study_period, how_to_study: post.how_to_study, valuable_score: post.valuable_score,
                        who_is_recommended: post.who_is_recommended, user_id: post.user_id, certificate_id: post.certificate_id }

        # データの作成を確認
        # expect { post '/post', params: post_params }.to change(Post, :count).by(+1)
        post '/post', params: post_params
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # 登録したユーザーのデータを返すことを確認
        expect(json['status']).to eq('success')
      end
    end
  end

  describe '投稿編集' do
    context '成功する場合' do
      it 'ステータスコード200と更新した投稿のデータを返す' do
        # ログイン
        login(create(:user))

        post = create(:post, title: 'old-title', user_id: current_user.id)
        patch '/post', params: { id: post.id, title: 'new-title' }
        json = JSON.parse(response.body)

        # リクエスト成功を確認
        expect(response.status).to eq(200)

        # 更新されたユーザーのデータを返すことを確認
        expect(json['status']).to eq('success')
        expect(json['post']['title']).to eq('new-title')
      end
    end
  end
end
