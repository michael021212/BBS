class CategoriesController < ApplicationController
  before_action :set_categories_for_partial, only: %i[show]

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.page(params[:page]).reverse_order
  end
end
