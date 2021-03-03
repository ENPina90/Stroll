class WalksController < ApplicationController
  before_action :set_walk, only: %i[show edit update destroy]

  def show
    authorize @walk
  end

  private

  def set_walk
    @walk = Walk.find(params[:id])
  end
end
