class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :salesman_admin
      can :manage, User do |user|
        user && user.role?(:salesman)
      end
      can :set_salesman, Project
    elsif user.role? :salesman
    elsif user.role? :marketing_admin
      can :manage, User do |user|
        user && user.role?(:marketing)
      end
      can :manage, Project
      can :set_marketing, Project
    elsif user.role? :marketing
      can :update, Project
    elsif user.role? :experimentor_admin
      can :manage, User do |user|
        user && user.role?(:experimentor)
      end
      can :update, Project
      can :set_experimenter, Project
    elsif user.role? :experimentor
      can :update, Project
    elsif user.role? :bioinformatician_admin
      can :manage, User do |user|
        user && user.role?(:bioinformatician)
      end
      can :update, Project
      can :set_bioinformatician
    elsif user.role? :bioinformatician
      can :update, Project
    else
      can :read, :all
    end
  end
end
