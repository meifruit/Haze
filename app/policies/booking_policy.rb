class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    record.user == user && record.service.user != user
  end

  def create?
    record.user == user && record.service.user != user
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user || record.service.user == user
  end

  def destroy?
    record.user == user || record.service.user == user
  end
end
