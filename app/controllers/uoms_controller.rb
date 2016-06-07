class UomsController < ApplicationController
  before_action :authenticate_user!

  def index
    property = params[:property]
    @uoms = Unitwise::Atom.all.select{|a|
      a.property == property
    }.map {|i| ["#{i.to_s(:names)} (#{i.to_s(:primary_code)})",i.to_s(:primary_code)] }
    @custom_units = CustomUnit.where(property: property)
    @uoms += @custom_units.map{|u| ["#{u.property} (#{u.uom})", u.uom] } if @custom_units.any?
    render json: @uoms
  end

end
