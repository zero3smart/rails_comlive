class StandardizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_referable, only: :new

  def new
    @standardization = Standardization.new(referable: @referable)
    render layout: !request.xhr?
  end

  def create
    @standardization = Standardization.new(standardization_params)
    @standardization.user_id = current_user.id
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

  def set_referable
    @referable = params[:referable_type].classify.constantize.find(params[:referable_id])
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