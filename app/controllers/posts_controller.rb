class PostsController < ApplicationController
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
    puts 'create method is being executed'
    puts "post_params: #{post_params}"

    @post = current_user.posts.new(post_params)

    if @post.save
      puts 'post was saved successfully'
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      puts 'post was not saved successfully'
      p @post.errors
      render :new
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
