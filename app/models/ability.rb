class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :salesman_admin
      can [:create, :destroy], User do |user|
        user.role?(:salesman)
      end
      can [:show, :index], User
      can :edit, User, :id => user.id

      can [:index, :show, :set_salesman], Project

      can :show, Customer

      can [:show, :index], Sample
    elsif user.role? :salesman
      can :show, User
      can :edit, User, :id => user.id

      can [:index, :show], Project do |project|
        project.salesman_id==user.id
      end

      can :show, Customer

      can :show, Sample
    elsif user.role? :marketing_admin
      can [:create, :destroy], User do |user|
        user.role?(:marketing)
      end
      can [:show, :index], User
      can :edit, User, :id => user.id

      can :manage, Project
      can :set_samples_complete, Project
      can :set_report_complete, Project do |p|
        p.analysis_done?
      end
      cannot [:set_experiments_complete, :set_analysis_complete], Project

      can :manage, Sample

      can :manage, Customer
    elsif user.role? :marketing
      can :show, User
      can :edit, User, :id => user.id

      can [:index, :new, :edit, :show,
           :create, :update, :set_samples_complete], Project
      can :set_report_complete, Project do |p|
        p.analysis_done?
      end

      can :manage, Sample

      can [:index, :new, :edit, :show, :create, :update], Customer
    elsif user.role? :experimenter_admin
      can [:create, :destroy], User do |user|
        user.role?(:experimenter)
      end
      can [:show, :index], User
      can :edit, User, :id => user.id

      can [:index, :show, :set_experimenter], Project
      can :set_experiments_complete, Project do |p|
        p.samples_received?
      end

      can [:index, :show], Sample

      can :show, Customer
    elsif user.role? :experimenter
      can :show, User
      can :edit, User, :id => user.id

      can [:index, :show], Project do |project|
        project.experimenter_id==user.id
      end
      can :set_experiments_complete, Project do |p|
        p.samples_received?
      end

      can [:index, :show], Sample

      can [:index, :show], Customer
    elsif user.role? :bioinformatician_admin
      can [:create, :destroy], User do |user|
        user.role?(:bioinformatician)
      end
      can [:show, :index], User
      can :edit, User, :id => user.id

      can [:index, :show, :set_bioinformatician], Project
      can :set_analysis_complete, Project do |p|
        p.experiments_done?
      end

      can [:index, :show], Sample

      can :show, Customer
    elsif user.role? :bioinformatician
      can :show, User
      can :edit, User, :id => user.id

      can [:index, :show], Project do |project|
        project.bioinformatician_id==user.id
      end
      can :set_analysis_complete, Project do |p|
        p.experiments_done?
      end

      can [:index, :show], Sample

      can [:index, :show], Customer
    else
      can :show, User

      can :show, Project
      can :search_projects, Project

      can :show, Sample

      can :show, Customer
    end
  end
end
