class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(author: current_user)

    if @like.save
      redirect_to user_post_path(@post.user, @post), notice: 'Post was successfully liked.'
    else
      redirect_to user_post_path(@post.user, @post), alert: 'Post could not be liked.'
    end
  end
end
