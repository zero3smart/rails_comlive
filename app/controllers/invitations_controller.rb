class InvitationsController < ApplicationController
  before_action :authenticate_user!, except: :accept
  before_action :set_app, except: :accept

  layout "landing", only: :accept

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = @app.invitations.new(invitation_params)
    @invitation.sender = current_user
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver!
      redirect_to @app, notice: "Invitation sent to #{@invitation.recipient_email}"
    else
      render :new
    end
  end

  def accept
    @invitation = Invitation.find_by(token: params[:token])
    if user_signed_in?
      redirect_to root_path, alert: "You are already signed in"
    else
      redirect_to root_path, alert: "Invalid invitation token" unless @invitation
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end

  def set_app
    @app = current_user.apps.find(params[:app_id])
  end
end