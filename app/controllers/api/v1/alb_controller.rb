class Api::V1::AlbController < ApplicationController
  # ALBのヘルスチェックをクリアするためのアクション設定
  def health_check
    head 200
  end
end
