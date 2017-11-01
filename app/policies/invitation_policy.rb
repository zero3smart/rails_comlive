class InvitationPolicy < ApplicationPolicy
  attr_reader :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation  = invitation
  end

  def new?
    is_owner?
  end

  def create?
    is_owner?
  end

  def accept?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def is_owner?
    invitation.app.memberships.where(user_id: user.id, owner: true).exists?
  end
end