# encoding: UTF-8
class Ocorrencia
  include Mongoid::Document

  field :codigo, :type => Integer
  field :grupo, :type => String

  embeds_many :ocorrencia_itens

  accepts_nested_attributes_for :ocorrencia_itens

  validates_presence_of :grupo
end
