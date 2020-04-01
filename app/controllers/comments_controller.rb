class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :set_categories_for_partial, only: %i[create]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post_id), notice: '書き込みました'
    else
      @post = Post.find(params[:id])
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :nickname, :body)
  end
end
