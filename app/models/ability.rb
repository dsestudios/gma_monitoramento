class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.role == "admin"
    can :manage, Post if user.role == "blog"
    can :manage, Test if user.role == "test"
  end

end