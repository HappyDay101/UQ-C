class ClassroomPolicy < ApplicationPolicy
  def index?
    user.teacher?
  end

  def show?
    user.teacher? || record.students.include?(user)
  end

  def new?
    user.teacher? # Adjust this based on your user roles
  end

  def create?
    user.teacher?
  end

  def add_students?
    user.teacher? && user == record.user
  end

  class Scope < Scope
    def resolve
      if user.teacher?
        scope.all
      else
        scope.joins(:participations).where(participations: { user_id: user.id })
      end
    end
  end
end
