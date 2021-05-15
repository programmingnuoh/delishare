class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @delis = @user.delis
  end
end
