class AppPolicy < ApplicationPolicy
  attr_reader :user, :app

  def initialize(user, app)
    @user = user
    @app  = app
  end

  def show?
    is_member?
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    is_member?
  end

  def update?
    is_member?
  end

  def destroy?
    false
  end

  def invite?
    is_owner?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def is_member?
    app.users.where(id: user.id).exists?
  end

  def is_owner?
    app.memberships.where(user_id: user.id, owner: true).exists?
  end
end