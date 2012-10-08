class Relatorio

  attr_reader :monitoramento, :operador, :data, :periodo

  def initialize(monitoramento)
    @monitoramento = monitoramento
  end

  def resumo_do_dia(data)
    agrupado_por_periodo = {"M" => [], "T" => [], "N" => [], "D" => []}
    order_by = [[:data, :asc], [:data_final, :asc]]

    @operador = []

    @monitoramentos = Monitoramento.where(monta_condicao(data)).order_by(order_by)
    @monitoramentos.each do |m|
      agrupado_por_periodo[m.periodo] << m
      @operador << m.user.nome if m.user
    end

    agrupado_por_periodo.each do |periodo, monitoramentos|
      novidades = []
      ocorrencias = []
      defeitos = []
      monitoramentos.each do |m|
        novidades << m.novidades
        ocorrencias << listagem_ocorrencias(m, false)
        defeitos << listagem_cameras_defeitos(m, false)
      end
      agrupado_por_periodo[periodo] = {ocorrencias: ocorrencias.flatten.sort.join("<br />").html_safe,
                                       novidades: novidades.join("<br /><br /><hr><br />").html_safe,
                                       defeitos: defeitos.flatten.sort.join("<br />").html_safe}
    end

    @data = I18n.l(data, :format => :complet)
    @periodo = "Todos"
    @operador = @operador.uniq.sort.join(", ")
    agrupado_por_periodo
  end

  def monta_condicao(data)
    condicao = {}
    if data
      condicao[:data.gte] = data
      condicao[:data.lte] = data
    end

    condicao
  end

  def listagem_ocorrencias(monitoramento = @monitoramento, html_safe = true)
    ocorrencias_lista = []
    monitoramento.ocorrencias.each do |o|
      ocorrencia = []
      ocorrencia << (o.hora ? I18n.l(o.hora, :format => :time) : t("messages.nao_informado"))
      ocorrencia << o.ocorrencia_item.ocorrencia.grupo
      ocorrencia << o.ocorrencia_item.descricao
      ocorrencia << o.camera.nome
      ocorrencias_lista << ocorrencia.join(" > ")
    end

    return ocorrencias_lista.sort.join("<br />").html_safe if html_safe
    ocorrencias_lista
  end

  def listagem_cameras_defeitos(monitoramento = @monitoramento, html_safe = true)
    cameras_defeito_lista = []
    monitoramento.camera_defeitos.each do |c|
      camera = []
      camera << c.camera.nome
      camera << c.defeito
      cameras_defeito_lista << camera.join(" > ")
    end

    return cameras_defeito_lista.sort.join("<br />").html_safe if html_safe
    cameras_defeito_lista
  end

  def listagem_cameras(monitoramento = @monitoramento)
    cameras_linhas = []
    linha = []

    cameras_ordenadas = monitoramento.cameras.order_by([[:nome, :asc]])
    cameras_ordenadas.each do |c|
      linha << c
      if linha.size == 3 or cameras_ordenadas.last == c
        cameras_linhas << linha
        linha = []
      end
    end
    cameras_linhas
  end

  private

  def proc_sort_date
    proc = Proc.new do |a,b|
      comp = (a.lastname <=> b.lastname)
      comp.zero? ? (a.firstname <=> b.firstname) : comp
    end

    proc
  end

end