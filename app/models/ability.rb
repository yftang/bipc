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
      can :show,   User
      can :edit,   User, :id => user.id
      can :index,  Project
      can :set_salesman, Project
      can :index,  Sample
    elsif user.role? :salesman
      can :show,   User
      can :edit,   User, :id => user.id
      can :index,  Project
    elsif user.role? :marketing_admin
      can :manage, User do |user|
        user && user.role?(:marketing)
      end
      can :show,   User
      can :edit,   User, :id => user.id
      can :manage, Project
      can :manage, Sample
    elsif user.role? :marketing
      can :update, Project
      can :show,   User
      can :edit,   User, :id => user.id
      can :manage, Sample
    elsif user.role? :experimentor_admin
      can :manage, User do |user|
        user && user.role?(:experimentor)
      end
      can :show,   User
      can :edit,   User, :id => user.id
      can :index,  Project
      can :update, Project
      can :set_experimenter, Project
      can :index,  Sample
    elsif user.role? :experimentor
      can :update, Project
      can :show,   User
      can :edit,   User, :id => user.id
      can :index,  Sample
    elsif user.role? :bioinformatician_admin
      can :manage, User do |user|
        user && user.role?(:bioinformatician)
      end
      can :show,   User
      can :edit,   User, :id => user.id
      can :index,  Project
      can :update, Project
      can :set_bioinformatician, Project
      can :index,  Sample
    elsif user.role? :bioinformatician
      can :update, Project
      can :show,   User
      can :edit,   User, :id => user.id
      can :index,  Sample
    else
      can :show, Project
      can :search_projects, Project
      can :show, User
    end
  end
end
