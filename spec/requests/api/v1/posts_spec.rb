require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe 'GET #index' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:post1) { create(:post, user: user1) }
    let!(:post2) { create(:post, user: user2) }

    it '投稿を全件取得する' do
      get '/api/v1/posts'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['posts'].size).to eq(2)
    end

    it '投稿に紐づくユーザー情報も含めてuser_idの降順で返す' do
      get '/api/v1/posts'
      expect(JSON.parse(response.body)['posts'][0]['user']).to eq(post2.user.as_json)
      expect(JSON.parse(response.body)['posts'][1]['user']).to eq(post1.user.as_json)
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post) }

    it '指定した投稿が返ってくる' do
      get "/api/v1/posts/#{post.id}", params: { id: post.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['post']['id']).to eq(post.id)
    end

    it '投稿に紐づくユーザー情報と資格情報も返す' do
      get "/api/v1/posts/#{post.id}", params: { id: post.id }
      expect(JSON.parse(response.body)['post']['user']).to eq(post.user.as_json)
      expect(JSON.parse(response.body)['post']['certificate']).to eq(post.certificate.as_json)
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let!(:certificate) { create(:certificate) }
    let!(:valid_params) do
      { title: 'ITパスポートに合格しました', certificate_id: certificate.id, study_period: 3,
        how_to_study: '過去問をひたすら解きました', valuable_score: 5, who_is_recommended: 'IT業界で働くすべての人におすすめ' }
    end
    let!(:token) { sign_in user }

    context 'ログイン済' do
      it '記事を作成する' do
        expect {
          post '/api/v1/posts', params: valid_params, headers: token
        }.to change(Post, :count).by(1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('success')
      end

      it 'パラメータに誤りがある場合は記事の作成に失敗する' do
        expect {
          post '/api/v1/posts', params: { title: '' }, headers: token
        }.not_to change(Post, :count)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['status']).to eq('error')
      end
    end

    context '未ログイン' do
      it 'ログインを要求する' do
        post '/api/v1/posts', params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT #update" do
    let!(:user) { create(:user) }
    let(:token) { sign_in user }
    let(:old_post) { create(:post, user_id: user.id) }

    context "ログイン済" do
      it "記事を更新する" do
        put "/api/v1/posts/#{old_post.id}", params: { title: "New Title" }, headers: token
        expect(old_post.reload.title).to eq("New Title")
      end

      it "ステータスコード200を返す" do
        put "/api/v1/posts/#{old_post.id}", params: { title: "New Title" }, headers: token
        expect(response).to have_http_status(:success)
      end
    end

    context "未ログイン" do
      it "記事の更新に失敗する" do
        put "/api/v1/posts/#{old_post.id}", params: { title: "New Title" }
        expect(old_post.reload.title).to_not eq("New Title")
      end

      it "ログインを要求する" do
        put "/api/v1/posts/#{old_post.id}", params: { title: "New Title" }
        expect(response).to have_http_status(:unauthorized)
      end
    end

  end
end
