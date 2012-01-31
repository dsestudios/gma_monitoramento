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
  has_and_belongs_to_many :ocorrencia_itens, inverse_of: nil
  has_and_belongs_to_many :camera_defeitos, inverse_of: nil

  accepts_nested_attributes_for :ocorrencia_itens, :allow_destroy => true #, :reject_if => lambda{|a| a[:ocorrencia].blank? or a[:descricao].blank? }
  accepts_nested_attributes_for :camera_defeitos, :allow_destroy => true, :reject_if => lambda{|a| a[:defeito].blank? or a[:camera].blank? }

  #validações


  def periodo_descricao
    Util.periodo_descricao(periodo)
  end

end
