class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
    @posts = @q.result(distinct: true).page(params[:page]).reverse_order
    @count = @q.result.count
  end

  def show
    @post = Post.find(params[:id])
    if user_signed_in?
      @comment = current_user.comments.build(post_id: params[:id])
    else
      @comment = Comment.new(post_id: params[:id])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: 'スレッドを作成しました'
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    redirect_to request.referer, alert: "スレッドを削除しました"
  end

  private

  def post_params
    user_columns = [:user_id, :title, :nickname, category_ids: []]
    params.require(:post).permit(user_columns)
  end
end
