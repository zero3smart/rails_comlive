class OwnershipsController < ApplicationController
  before_action :logged_in_using_omniauth?

  def create
    parent_type, parent_id = ownership_params[:parent_id].split("-")
    attributes = ownership_params.merge(parent_id: parent_id, parent_type: parent_type)
    @ownership = Ownership.create(attributes)
    @app = @ownership.child.app
    if @ownership.save
      redirect_to [@app,@ownership.child], notice: "Ownership claimed, we'll contact you for verification"
    else
      redirect_to [@app,@ownership.child], alert: "Error: #{@ownership.errors.full_messages.join}"
    end
  end

  private

  def ownership_params
    params.require(:ownership).permit(:parent_id, :parent_type, :child_id, :child_type)
  end
end