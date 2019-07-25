class MapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def results?
    true
  end

  def save_marker?
    true
  end

  def create?
    true
  end
end
