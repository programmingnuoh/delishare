class DelisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :deli_find, only: [:show, :edit, :update, :destroy, :confirm]
  before_action :user_check, only: [:edit, :destroy, :confirm]

  def index
    @delis = Deli.includes(:user).order("created_at DESC").limit(6)
  end

  def new
    @form = DelisTag.new
  end

  def create
    @form = DelisTag.new(deli_params)
    tag_list = params[:delis_tag][:tagname].split(",")
    if @form.valid?
      @form.save(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @tag_list = @deli.tags.pluck(:tagname).join(",")
    @form = DelisTag.new(deli: @deli)
  end

  def update
    @form = DelisTag.new(deli_update_params, deli: @deli)
    tag_list = params[:delis_tag][:tagname].split(",")
    if @form.update(tag_list)
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

  def search
    @p = Deli.ransack(params[:q])
    @results = @p.result(distinct: true).includes(:category, :tags)
  end

  private

  def deli_params
    params.require(:delis_tag).permit(:name, :text, :category_id, :supermarket_id, :image, tagname:[]).merge(user_id: current_user.id)
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
