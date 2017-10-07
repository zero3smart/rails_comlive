class Users::InvitationsController < Devise::InvitationsController
  def new
    self.resource = resource_class.new
    render layout: !request.xhr?
  end


end