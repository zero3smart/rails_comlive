class StandardizationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @standardization = Standardization.new
  end

  def create
    @standardization = Standardization.create(standardization_params.merge(user_id: current_user.id))
    if @standardization.save
      @referable = @standardization.referable
      redirect_to object_url(@referable), notice: "Standard successfully assigned"
    else
      render :new
    end
  end

  private

  def standardization_params
    params.require(:standardization).permit(:standard_id,:referable_type,:referable_id)
  end

  def object_url(model)
    case model
      when Brand
        model
      else
        [model.app, model]
    end
  end
end