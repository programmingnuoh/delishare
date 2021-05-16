class UsersController < ApplicationController
  before_action :user_find, only:[:show, :edit, :update]
  before_action :user_check, only:[:edit]
  
  def show
    @delis = @user.delis
  end

  def edit
    
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private
  def user_find
    @user = User.find(params[:id])    
  end

  def user_check
    if current_user.id != @user.id
      redirect_to user_path(@user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
