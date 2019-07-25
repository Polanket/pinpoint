class MapPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def add_location?
    true
  end

  def new?
    true
  end
end
