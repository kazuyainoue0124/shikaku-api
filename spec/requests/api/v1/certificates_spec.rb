require 'rails_helper'

RSpec.describe 'Api::V1::Certificates', type: :request do
  describe 'GET /index' do
    let!(:certificate1) { create(:certificate) }
    let!(:certificate2) { create(:certificate) }

    it '資格データを全件取得する' do
      get '/api/v1/certificates'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['certificates'].size).to eq(2)
    end
  end
end
