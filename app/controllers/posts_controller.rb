class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
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
