# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.role == 'Instructor'
      can :manage, Course, user_id: user.id
      can :manage, Lecture
      can :manage, Quiz
      can :manage, Question
      can :manage, Room
    elsif user.role == 'Student'
      can :read, Course
      can :read, Lecture
    else
      can :read, Course
      can :read, Lecture
    end
  end
end
