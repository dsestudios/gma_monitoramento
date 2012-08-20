# encoding: UTF-8
class OcorrenciaItem
  include Mongoid::Document

  field :descricao, :type => String
  belongs_to :ocorrencia, :class_name => "Ocorrencia"

  has_many :monitoramento_ocorrencias
  has_and_belongs_to_many :monitoramentos

  #validates_presence_of :descricao  #da o pau pois se ele é removido do form e estiver em branco tenta focar e ai da pau
  validates_uniqueness_of :descricao, :case_sensitive => false, :scope => :ocorrencia_id
  validates_length_of :descricao, :in => 1..50, :allow_blank => false, :allow_nil => false

  # Retorna a quantidade desta ocorrencia em cada mes do ano
  # @param filtros :ano - Filtra per ano
  #                :camera - Filtra pela camera
  #                :operador - Filtra pelo operador
  # @return Hash com todos os meses
  #         Ex.: {1 => 10, 2 => 0, 3 => 5...}
  def quantidade_ocorrencia_todos_meses(filtros={})
    ano = trata_todos(filtros[:ano])
    camera = trata_todos(filtros[:camera])
    operador = trata_todos(filtros[:operador])

    ano = ano.to_i if not ano.nil?
    camera = BSON::ObjectId(camera) if not camera.nil?
    operador = BSON::ObjectId(operador) if not operador.nil?

    #cria hash meses
    meses = {}
    12.times do |i|
      meses[i+1] = 0;
    end

    monitoramentos = monitoramento_ocorrencias
    monitoramentos.each do |m|
      next if m.monitoramento.nil?
      next if m.monitoramento.data.nil?
      next if !ano.nil? && m.monitoramento.data.year != ano
      next if !camera.nil? && m.camera.id != camera
      next if !operador.nil? && m.monitoramento.user.id != operador

      meses[m.monitoramento.data.month] += 1
    end

    meses
  end

  private

  def trata_todos(valor)
   if not valor.nil? and (valor.blank? or valor[0,1] == "T")
     return nil
   end

   valor
  end


end

