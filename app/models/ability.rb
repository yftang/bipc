class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :salesman_admin
      can :manage, User do |user|
        user && user.role? :salesman
      end
    elsif user.role? :salesman
    elsif user.role? :marketing_admin
      can :manage, User do |user|
        user && user.role? :marketing
      end
    elsif user.role? :marketing
    elsif user.role? :bioinformatician_admin
      can :manage, User do |user|
        user && user.role? :bioinformatician
      end
    elsif user.role? :bioinformatician
    else
      can :read, :all
    end
  end
end
