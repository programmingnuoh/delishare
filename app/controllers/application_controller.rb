class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_deli

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image])
  end

  def search_deli
    @search = Deli.search(params[:keyword])
    # @search_delis = @search.result
    @categories = Category.all
    @supermarkets = Supermarket.all
  end
end
