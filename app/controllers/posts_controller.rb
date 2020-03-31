class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :set_categories_for_partial, only: %i[index new show create]

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

  private

  def post_params
    params.require(:post_form).permit(:user_id, :title, :nickname, :body, category_ids:[])
  end
end
