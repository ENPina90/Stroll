class StrollSettingsController < ApplicationController
  before_action :set_stroll_setting, only: %i[show edit update]

  def show
    authorize @stroll_setting
  end

  def edit
    authorize @stroll_setting
  end

  def create
    @stroll_setting = StrollSetting.new(booking_params)
    @stroll_setting.user = current_user
    authorize @stroll_setting
    if @stroll_setting.save
      redirect_to stroll_setting_path(@stroll_setting)
    else
      render :show
    end
  end

  def update
    authorize @stroll_setting
    if @stroll_setting.update!(stroll_setting_params)
      redirect_to stroll_setting_path(@stroll_setting), notice: 'Settings were successfully updated'
    else
      render :edit
    end
  end

  private

  def stroll_setting_params
    params.require(:stroll_setting).permit(:category, :significance, :cost, :newness)
  end

  def set_stroll_setting
    @stroll_setting = StrollSetting.where(user: current_user).find(params[:id])
  end
end
