class SpecificationPolicy < ApplicationPolicy
  attr_reader :user, :specification

  def initialize(user, specification)
    @user           = user
    @specification  = specification
  end

  def show?
    visible? || member?(specification.app)
  end

  def edit?
    member?(specification.app)
  end

  class Scope < Scope
    def resolve
      return scope.where(visibility: "publicized") if user.nil?
      scope.all
    end
  end

  private

  def visible?
    specification.visibility_status == "Public"
  end
end