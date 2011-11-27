class Ability
  include CanCan::Ability

  def self.tipos_de_usuarios
    {:admin => "Administrador",
     :monitor => "Monitor"}
  end

  def initialize(user)
    can :manage, :all if user.role == :admin
    can :manage, :all if user.role == :monitor
    can :manage, Post if user.role == "blog"
    can :manage, Test if user.role == "test"
  end

end