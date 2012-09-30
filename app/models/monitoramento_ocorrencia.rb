# encoding: UTF-8
class MonitoramentoOcorrencia
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  belongs_to :monitoramento, index: true #ocorrencia pertence a um Monitoramento
  belongs_to :ocorrencia_item, index: true #ocorrencia pertence a uma ocorrencia item
  belongs_to :camera, index: true #uma camera pertence a uma ocorrencia
  field :hora, :type => Time

  #CAMPOS REPLICADOS PARA PESQUISA
  belongs_to :user, index: true
  belongs_to :ocorrencia, :class_name => "Ocorrencia", index: true
  field :data, :type => Date

  #validates_presence_of :descricao  #da o pau pois se ele é removido do form e estiver em branco tenta focar e ai da pau
  #validates_uniqueness_of :descricao, :case_sensitive => false, :scope => :ocorrencia_id
  #validates_length_of :descricao, :in => 1..50, :allow_blank => false, :allow_nil => false

end
