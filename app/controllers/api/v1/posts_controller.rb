class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[create update]

  def index
    @posts = if params[:user_id].nil?
               Post.all.order(:id)
             else
               Post.find_by(user_id: params[:user_id])
             end
    render json: { posts: @posts.as_json(include: :user) }
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: @post.as_json(include: %i[user certificate]) }
  end

  def create
    @post = current_api_v1_user.posts.build(post_params)
    if @post.save
      render json: { status: :success }
    else
      render json: { status: 'error', message: @post.errors.full_messages.first }
    end
  end

  def update
    @post = current_api_v1_user.posts.find(params[:id])
    if @post.update(post_params)
      render json: { status: :success, post: @post.as_json }
    else
      render json: { status: 'error', message: @post.errors.full_messages.first }
    end
  end

  private

  def post_params
    params.permit(:user_id, :title, :certificate_id, :study_period, :how_to_study, :valuable_score, :who_is_recommended)
  end
end
