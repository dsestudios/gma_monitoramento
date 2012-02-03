# encoding: UTF-8
class Ocorrencia
  include Mongoid::Document

  field :grupo, :type => String

  has_many :ocorrencia_itens

  accepts_nested_attributes_for :ocorrencia_itens, :allow_destroy => true, :reject_if => lambda{|a| a[:descricao].blank?}

  validates_presence_of :grupo
  validates_uniqueness_of :grupo
  validates_associated :ocorrencia_itens

end

