class UsersController < ApplicationController

  def show
    authorize @user
    @user = User.find(params[:id])
    # @user = User.where(user: current_user).find(params[:id])
  end
end
