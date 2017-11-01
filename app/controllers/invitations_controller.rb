class InvitationsController < ApplicationController
  before_action :authenticate_user!, except: :accept
  before_action :set_app, except: :accept
  after_action :verify_authorized, except: :index

  layout "landing", only: :accept

  def new
    @invitation = Invitation.new(app_id: @app.id)
    authorize @invitation
  end

  def create
    @invitation = @app.invitations.new(invitation_params)
    authorize @invitation
    @invitation.sender = current_user
    if @invitation.save
      InvitationMailer.invite(@invitation).deliver!
      redirect_to @app, notice: "Invitation sent to #{@invitation.recipient_email}"
    else
      render :new
    end
  end

  def accept
    authorize Invitation
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
    @app = App.find(params[:app_id])
  end
end