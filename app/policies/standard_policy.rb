class StandardPolicy < ApplicationPolicy
  attr_reader :user, :standard

  def initialize(user, standard)
    @user      = user
    @standard  = standard
  end

  def show?
    visible?
  end

  def edit?
    false
  end

  class Scope < Scope
    def resolve
      return scope.where(visibility: "publicized") if user.nil?
      scope.all
    end
  end

  private

  def visible?
    standard.visibility_status == "Public"
  end
end