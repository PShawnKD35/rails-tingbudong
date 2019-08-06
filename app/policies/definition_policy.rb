class DefinitionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def like?
    true
  end

  def unlike?
    record.user == user
  end
end
