class WalksController < ApplicationController
  before_action :set_walk, only: %i[show edit update destroy]

  def show
    authorize @walk
  end


  private

  def walk_params
    params.require(:walk).permit(:stroll_setting_id)
  end

  def set_walk
    @walk = current_user.walks.last
  end
end
