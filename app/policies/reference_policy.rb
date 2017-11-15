class ReferencePolicy < ApplicationPolicy
  attr_reader :user, :reference

  def initialize(user, reference)
    @user       = user
    @reference  = reference
  end

  def show?
    visible? || member?(reference.app)
  end

  def edit?
    member?(reference.app)
  end

  class Scope < Scope
    def resolve
      return scope.where(visibility: "publicized") if user.nil?
      scope.all
    end
  end

  private

  def visible?
    reference.visibility_status == "Public"
  end
end