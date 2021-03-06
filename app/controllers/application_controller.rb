class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query

  def after_sign_in_path_for(resource)
    root_path
  end

  def set_query
    @q = Post.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_categories_for_partial
    @categories = Category.all
  end
end
