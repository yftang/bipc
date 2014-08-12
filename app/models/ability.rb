class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :administrator
      can :manage, :all
    elsif user.role? :operator
      can :manage, Project
    else
      can :read, :all
    end
  end
end
