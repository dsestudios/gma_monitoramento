# encoding: UTF-8
class Monitoramento
  include Mongoid::Document

  field :data, :type => Date
  field :periodo, :type => String   #Manha - Tarde - Noite
  field :novidades, :type => String
  field :efetivado, :type => Boolean

  #relacionamentos
  belongs_to :user
  has_and_belongs_to_many :cameras, inverse_of: nil
  has_and_belongs_to_many :ocorrencias, inverse_of: nil

  #validações


  def periodo_descricao
    Util.periodo_descricao(periodo)
  end

end
