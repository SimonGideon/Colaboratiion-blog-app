class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
    @like = @post.likes.find_by(author: current_user)
  end
end
