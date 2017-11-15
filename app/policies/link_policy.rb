class LinkPolicy < ApplicationPolicy
  attr_reader :user, :link

  def initialize(user, link)
    @user  = user
    @link  = link
  end

  def show?
    visible? || member?(link.app)
  end

  def edit?
    member?(link.app)
  end

  class Scope < Scope
    def resolve
      return scope.where(visibility: "publicized") if user.nil?
      scope.all
    end
  end

  private

  def visible?
    link.visibility_status == "Public"
  end
end