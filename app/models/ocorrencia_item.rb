# encoding: UTF-8
class OcorrenciaItem
  include Mongoid::Document

  field :descricao, :type => String

  embedded_in :ocorrencia

  #validates_presence_of :descricao  #da o pau pois se ele é removido do form e estiver em branco tenta focar e ai da pau
  validates_uniqueness_of :descricao, :scoped => :ocorrencia
  validates_length_of :descricao, :in => 1..30, :allow_blank => false, :allow_nil => false

end
