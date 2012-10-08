# encoding: UTF-8
class Monitoramento
  include Mongoid::Document
  include Mongoid::Search

  field :data, :type => Date
  field :data_final, :type => Date  #quando é perido noturno começa em um dia e termina no outro
  field :periodo, :type => String   #Manha - Tarde - Noite
  field :novidades, :type => String
  field :efetivado, :type => Boolean

  #relacionamentos
  belongs_to :user, index: true
  belongs_to :visor, index: true
  has_many :camera_defeitos
  has_many :ocorrencias, :class_name => "MonitoramentoOcorrencia"
  has_and_belongs_to_many :cameras, index: true

  #ASSOCIACAO NAO MAIS USADA -> passou a usar o :ocorrencias
  #has_and_belongs_to_many :ocorrencia_itens
  #accepts_nested_attributes_for :ocorrencia_itens, :allow_destroy => true, :reject_if => lambda{|a| a[:descricao].blank? }

  accepts_nested_attributes_for :camera_defeitos, :allow_destroy => true, :reject_if => lambda{|a| a[:defeito].blank? }

  validates_associated :user, :visor, :cameras

  search_in :novidades,
            {:camera_defeitos => [:defeito, :camera => :nome],
            :ocorrencias => [:camera => :nome, :ocorrencia_item => :descricao]},
            {:match => :all,
            #:allow_empty_search => true,
            :relevant_search => true,
            :ignore_list => Rails.root.join("config", "ignorelist.yml")}

  def periodo_descricao
    UtilGma.periodo_descricao(periodo)
  end

end
