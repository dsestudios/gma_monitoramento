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

    can [:read], Monitoramento
    can [:update, :create, :destroy], Monitoramento do |m|
      if m.user.nil?
        true
      else
        #somente podera ter acesso se for Monitoramento do usuário logado
        #e não ter passado 48 horas desde seu lançamento
        m.user.id == user.id and (UtilGma.periodo_hora_inicial(m.periodo, m.data) + 48.hours) > Time.now
      end
    end
    can [:remove_ocorrencia], Monitoramento
  end

  def sem_permissao
    can [], []
  end

end