class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
    @posts = @q.result(distinct: true).page(params[:page]).reverse_order
    @count = @q.result.count
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.comments.page(params[:page])
    if user_signed_in?
      @comment = current_user.comments.build(post_id: params[:id])
    else
      @comment = Comment.new(post_id: params[:id])
    end
  end

  def new
    @post_form = PostForm.new
  end

  def create
    @post_form = PostForm.new(post_params.merge(user_id: current_user.id))
    if @post_form.save
      id = Post.last
      redirect_to post_path(id), notice: 'スレッドを作成しました'
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
    params.require(:post_form).permit(:user_id, :title, :nickname, :body, category_ids:[])
  end
end
