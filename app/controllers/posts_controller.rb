class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    redirect_to user_post_path(@user, @post) if params[:post_number]
    @post_number = @user.posts.find_index(@post) + 1
    @like = @post.likes.find_by(author: current_user)
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  before_action :set_user

  def new
    @post = @user.posts.new
  end

  def likes
    @post = Post.find(params[:id])
    if @post.likes.create(author_id: current_user.id)
      flash[:success] = 'You liked the post.'
    else
      flash[:error] = 'Failed to like the post.'
    end
    redirect_to user_posts_path
  end

  def create
    @user = User.find(params[:user_id])

    if @user.id != current_user.id
      flash[:alert] = 'You cannot create posts for another user.'
      redirect_to root_path and return
    end

    @post = current_user.posts.build(post_params)
    @post.author_id = current_user.id

    if @post.save
      puts 'post was saved successfully'
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      puts 'post was not saved successfully'
      p @post.errors
      render :new
    end
  end

  def comments
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy
    @user.update(post_counter: @user.post_counter - 1)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
