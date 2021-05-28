class DelisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :deli_find, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :user_check, only: [:edit, :destroy, :confirm]

  def index
    @delis = Deli.includes(:user).order("created_at DESC")
  end

  def new
    @form = DelisTag.new
  end

  def create
    @form = DelisTag.new(deli_params)
    # tag_list = params[:delis_tag][:tagname].split(",")
    if @form.valid?
      @form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @tag_list = @deli.tags.pluck(:tagname).join(",")
    @form = DelisTag.new
  end

  def update
    # binding.pry
    @form = DelisTag.new(deli_update_params)
    if @form.update
      redirect_to deli_path(@form.id)
    else
      render :edit
    end
  end

  def show
  end

  def confirm
  end

  def destroy
    @form.destroy
  end

  private

  def deli_params
    params.require(:delis_tag).permit(:name, :text, :category_id, :supermarket_id, :image, :tagname).merge(user_id: current_user.id)
  end

  def deli_update_params
    params.require(:delis_tag).permit(:name, :text, :category_id, :supermarket_id, :image, :tagname).merge(user_id: current_user.id, deli_id: params[:id])    
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
