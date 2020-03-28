class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post_id), notice: '書き込みました'
    else
      @post = Post.find(params[:post_id])
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :nickname, :body)
  end
end
