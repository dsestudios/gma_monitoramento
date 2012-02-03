class Visor
  include Mongoid::Document
  field :nome, :type => String
  field :numero, :type => Integer

  #relacionamentos
  has_many :monitoramentos

  validates_presence_of	:nome, :numero
  validates_numericality_of :numero, :only_integer => true, :message => I18n.t("validation.must_be_number")
  validates_uniqueness_of :numero
end
