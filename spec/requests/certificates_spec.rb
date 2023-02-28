require 'rails_helper'

RSpec.describe 'Certificates', type: :request do
  describe '全ての資格を取得する' do
    before do
      create_list(:certificate, 10)
      get '/certificates'
    end

    it 'ステータスコード200を返す' do
      expect(response.status).to eq(200)
    end

    it '正しい数のデータを返す' do
      json = JSON.parse(response.body)
      expect(json['certificates'].length).to eq(10)
    end
  end
end
