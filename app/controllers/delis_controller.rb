class DelisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @delis = Deli.all
  end

  def new
    @deli = Deli.new
  end

  def create
    @deli = Deli.new(deli_params)
    if @deli.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
      
  end

  def update
      
  end

  def show
      
  end

  def destroy
      
  end

  private
  def deli_params
    params.require(:deli).permit(:name, :text, :category_id, :supermarket_id, :image).merge(user_id: current_user.id)
  end
end
