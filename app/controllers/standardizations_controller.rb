class StandardizationsController < ApplicationController
  before_action :logged_in_using_omniauth?

  def new
    @standardization = Standardization.new
  end

  def create
    @standardization = Standardization.create(standardization_params.merge(user_id: current_user.id))
    if @standardization.save
      @referable = @standardization.referable
      redirect_to [@referable.app, @referable], notice: "Standard successfully assigned"
    else
      render :new
    end
  end

  private

  def standardization_params
    params.require(:standardization).permit(:standard_id,:referable_type,:referable_id)
  end
end