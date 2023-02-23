class Api::V1::AlbController < ApplicationController
  # ALBのヘルスチェックをクリアするためのアクション設定
  def health_check
    render status: 200, json: {result: 'OK'}
  end
end
