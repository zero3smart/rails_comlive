class SessionsController < ApplicationController
  layout "landing", only: :new

  def new

  end

  def destroy
    session.delete(:user_id)
    redirect_to auth0_logout_path, notice: "Signed out successfully."
  end

  private

  def auth0_logout_path
    Rails.env.eql?("test") ? root_path : "#{ENV["AUTH0_LOGOUT_URL"]}?returnTo=#{root_url}"
  end
end