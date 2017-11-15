class PackagingPolicy < ApplicationPolicy
  attr_reader :user, :packaging

  def initialize(user, packaging)
    @user       = user
    @packaging  = packaging
  end

  def show?
    visible? || member?(packaging.app)
  end

  def edit?
    member?(packaging.app)
  end

  class Scope < Scope
    def resolve
      return scope.where(visibility: "publicized") if user.nil?
      scope.all
    end
  end

  private

  def visible?
    packaging.visibility_status == "Public"
  end
end