# encoding: UTF-8
class Ocorrencia
  include Mongoid::Document

  field :codigo, :type => Integer
  field :grupo, :type => String

  embeds_many :ocorrencia_itens

  accepts_nested_attributes_for :ocorrencia_itens, :allow_destroy => true, :reject_if => lambda{|a| a[:descricao].blank?}

  validates_presence_of :grupo
  validates_uniqueness_of :grupo
  validates_presence_of :ocorrencia_itens, :message => "É necessario informar pelo menos uma ocorrência."

#  validates_acceptance_of :ocorrencia_itens, :if => :validates_itens_preenchido, :message => "É necessario informar pelo menos uma ocorrência."

  def validates_itens_preenchido
    ocorrencia_itens.each do |i|
      return true if i.descricao.blank?
    end
    false
  end

end

