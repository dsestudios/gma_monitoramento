# encoding: UTF-8
class Monitoramento
  include Mongoid::Document

  field :data, :type => Date
  field :data_final, :type => Date  #quando é perido noturno começa em um dia e termina no outro
  field :periodo, :type => String   #Manha - Tarde - Noite
  field :novidades, :type => String
  field :efetivado, :type => Boolean

  #relacionamentos
  belongs_to :user
  belongs_to :visor
  has_many :camera_defeitos
  has_many :ocorrencias, :class_name => "MonitoramentoOcorrencia"
  has_and_belongs_to_many :cameras
  has_and_belongs_to_many :ocorrencia_itens


  accepts_nested_attributes_for :ocorrencia_itens, :allow_destroy => true, :reject_if => lambda{|a| a[:descricao].blank? }
  accepts_nested_attributes_for :camera_defeitos, :allow_destroy => true, :reject_if => lambda{|a| a[:defeito].blank? }

  validates_associated :user, :visor, :cameras

  def periodo_descricao
    Util.periodo_descricao(periodo)
  end

end
