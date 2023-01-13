class FollowsController < ApplicationController
  before_action :logged_in?

  def index
    @follows = current_user.active_follows.where(send_follow_id: current_user.id)
    render json: { status: :success, follows: @follows.as_json(include: :receive_follow_user) }
  end

  def create
    @follow = current_user.active_follows.build(send_follow_id: current_user.id, receive_follow_id: params[:receive_follow_id])
    if @follow.save
      render json: { status: :success }
    else
      render json: { status: 'error', message: @follow.errors.full_messages.first }
    end
  end

  def destroy
    @follow = current_user.active_follows.find_by(send_follow_id: current_user.id, receive_follow_id: params[:receive_follow_id])
    if @follow.destroy
      render json: { status: :success }
    else
      render json: { status: 'error', message: @follow.errors.full_messages.first }
    end
  end

  private

  def follow_params
    params.permit(:send_follow_id, :receive_follow_id)
  end
end
