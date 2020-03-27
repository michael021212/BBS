class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def index
  end

  def show
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

  private

  def post_params
    user_columns = [:user_id, :title, :nickname, category_ids: []]
    params.require(:post).permit(user_columns)
  end
end
