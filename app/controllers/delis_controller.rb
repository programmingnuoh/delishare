class DelisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :deli_find, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :user_check, only: [:edit, :destroy, :confirm]

  def index
    @delis = Deli.includes(:user).order("created_at DESC")
  end

  def new
    @deli = DelisTag.new
  end

  def create
    @deli = DelisTag.new(deli_params)
    if @deli.valid?
      @deli.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @deli.update(deli_params)
      redirect_to deli_path(@deli.id)
    else
      render :edit
    end
  end

  def show
  end

  def confirm
  end

  def destroy
    @deli.destroy
  end

  private

  def deli_params
    params.require(:delis_tag).permit(:name, :text, :category_id, :supermarket_id, :image, :tagname).merge(user_id: current_user.id)
  end

  def deli_find
    @deli = Deli.find(params[:id])
  end

  def user_check
    if current_user.id != @deli.user_id
      redirect_to deli_path(@deli.id) 
    end
  end

end
