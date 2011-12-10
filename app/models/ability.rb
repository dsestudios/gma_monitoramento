class Ability
  include CanCan::Ability

  def self.tipos_de_usuarios
    {:admin => "Administrador",
     :monitor => "Monitor"}
  end

  def initialize(user)
    return sem_permissao if user.nil? or user.role.nil?
    permissao_de_administrador if user.role.to_sym == :admin
    permissao_de_monitor(user) if user.nil? or user.role.to_sym == :monitor
  end

  private

  def permissao_de_administrador
    can [:manage], :all
  end

  def permissao_de_monitor(user)
    can [:update], User, :id => user.id #somente poderar alterar a propria conta
  end

  def sem_permissao
    can [], []
  end

end