class MapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def add_location?
    true
  end

  def create?
    true
  end
end
