class Api::V1::BookmarksController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    @bookmarks = current_api_v1_user.bookmarks.where(user_id: current_api_v1_user.id)
    render json: { bookmarks: @bookmarks.as_json(include: { post: { include: :user } }) }
  end

  def create
    @bookmark = current_api_v1_user.bookmarks.build(user_id: current_api_v1_user.id, post_id: params[:post_id])
    if @bookmark.save
      render json: { status: :success }
    else
      render json: { status: 'error', message: @bookmark.errors.full_messages.first }
    end
  end

  def destroy
    @bookmark = current_api_v1_user.bookmarks.find_by(user_id: current_api_v1_user.id, post_id: params[:post_id])
    if @bookmark.destroy
      render json: { status: :success }
    else
      render json: { status: 'error', message: @bookmark.errors.full_messages.first }
    end
  end

  private

  def bookmark_params
    params.permit(:user_id, :post_id)
  end
end
