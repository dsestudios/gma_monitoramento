class Estatistica

  class ViewResumo
    attr_accessor :descricao, :meses

    def initialize(descricao, hash_meses)
      hash_meses ||= {}
      @descricao=descricao
      @meses=hash_meses.each{|k,v| hash_meses[k]=v.size}
      @meses[13]= @meses.values.sum
    end

    def mes_soma_exibicao(mes)
      mes = @meses[mes] || 0
      mes = "&nbsp;".html_safe if mes == 0
      mes
    end

    def descricao
      @descricao[0..36]
    end

  end

  attr_reader :grupo

  def initialize(filtros={})
    @periodo = create_parametro(filtros[:ano], ano_periodo(filtros[:ano]))
    @grupo = create_parametro(filtros[:grupo], Ocorrencia)
    @camera = create_parametro(filtros[:camera], Camera)
    @operador = create_parametro(filtros[:operador], User)
  end

  def gera_dados_estatisticos
    itens = {}
    MonitoramentoOcorrencia.where(monta_condicao).each do |o|
      chave = o.ocorrencia_item_id
      hash_meses = itens[chave]
      unless hash_meses.nil?
        hash_meses[o.data.month] ||= []
        hash_meses[o.data.month] << o
        next
      end
      hash_meses = {o.data.month => [o]}
      itens[chave] = hash_meses
    end

    itens
  end

  def ocorrencia_itens_por_mes(estatistica_dados)
    vr_total_vertical = ViewResumo.new("TOTAL", {})

    estatistica = []
    ocorrencia_itens.asc(:descricao).each do |oi|
      vr = ViewResumo.new(oi.descricao, estatistica_dados[oi.id])
      vr.meses.each do |k,v|
        vr_total_vertical.meses[k] ||= 0
        vr_total_vertical.meses[k] += v
      end
      estatistica << vr
    end

    estatistica << vr_total_vertical
    estatistica
  end

  private

  def ocorrencia_itens
    return @ocorrencia_itens if @ocorrencia_itens
    @ocorrencia_itens = @grupo.nil? ? OcorrenciaItem.all : @grupo.ocorrencia_itens
  end

  def monta_condicao
    condicao = {}
    condicao[:ocorrencia_id] = @grupo.id if @grupo
    condicao[:camera_id] = @camera.id if @camera
    condicao[:user_id] = @operador.id if @operador
    if @periodo
      condicao[:data.gte] = @periodo[:inicio]
      condicao[:data.lte] = @periodo[:fim]
    end

    condicao
  end


  def ano_periodo(ano)
    return nil unless ano

    date = Time.new(ano, 1, 1).to_date
    {:inicio => date.at_beginning_of_year,
     :fim => date.at_end_of_year}
  end

  def create_parametro(value, valid_value, invalid_value = nil)
    return invalid_value if value.blank?

    if valid_value.instance_of?(Class)
      return valid_value.find(value)
    end

    valid_value
  end

end