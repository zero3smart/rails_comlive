class InvitationsController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :set_app

  def new
    @user = User.new
    render layout: !request.xhr?
  end

  def create
    @user = User.invite!(:email => params[:email])
    if @user.save
      @user.invited_apps << @app
      flash[:notice] = "Invitation sent to #{@user.email}"
      redirect_back(fallback_location: app_path(@app))
    else
      render :new
    end
  end

  private

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end
end