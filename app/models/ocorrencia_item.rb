# encoding: UTF-8
class OcorrenciaItem
  include Mongoid::Document

  field :descricao, :type => String

  embedded_in :ocorrencia

  #validates_presence_of :descricao
end
