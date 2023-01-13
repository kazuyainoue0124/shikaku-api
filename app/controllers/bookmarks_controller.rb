class BookmarksController < ApplicationController
  before_action :logged_in?

  def index
    @bookmarks = current_user.bookmarks.where(user_id: current_user.id)
    render json: { status: :success, bookmarks: @bookmarks.as_json(include: { post: { include: :user } }) }
  end

  def create
    @bookmark = current_user.bookmarks.build(user_id: current_user.id, post_id: params[:post_id])
    if @bookmark.save
      render json: { status: :success }
    else
      render json: { status: 'error', message: @bookmark.errors.full_messages.first }
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(user_id: current_user.id, post_id: params[:post_id])
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
