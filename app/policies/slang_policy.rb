class SlangPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.limit(10)
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    record.user == user
  end

  def tags?
    true
  end

  def add_tag?
    true
  end
end
