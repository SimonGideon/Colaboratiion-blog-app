class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])

    if @user.id != current_user.id
    flash[:alert] = "You cannot create comments for another user."
    redirect_to root_path and return
    end

    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_posts_path, notice: 'Comment was successfully created.'
    else
      render :new
    end

    def destroy
      @comment.destroy
      @comment.update(comments_counter: @post.comments_counter - 1)
      respond_to do |format|
      format.html { redirect_to root_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
