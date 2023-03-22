class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.find_by(id: params[:post_id])
    @like = @post.likes.find_by(author: current_user) if @post
  end
end
