class BuscaController < ApplicationController
  def index
    return busca_rapida if params[:busca_rapida]

    carrega_filtros

    return resultado if params[:commit]
  end

  def resultado
    busca = params[:busca]
    periodo = busca[:periodo]
    periodo.delete("") if periodo

    #TODO arrumar isso.. ver pq a data nao vem concatenada em um unico campo (multiparam)
    @periodo_inicial = busca["periodo_inicial(3i)"] + "/" + busca["periodo_inicial(2i)"] + "/" + busca["periodo_inicial(1i)"]
    @periodo_final = busca["periodo_final(3i)"] + "/" + busca["periodo_final(2i)"] + "/" + busca["periodo_final(1i)"]

    condicao = { :data.gte => @periodo_inicial, :data.lte => @periodo_final }
    condicao[:user_id] = busca[:operador] if busca[:operador].present?

    varios = {}
    varios[:periodo] = periodo if periodo.present?
    varios[:camera_ids] = busca[:cameras] if busca[:cameras]

    order_by = [[:data, :desc], [:data_final, :desc]]

    @buscando_por = busca[:busca_query]
    if @buscando_por.present?
      @monitoramentos = Monitoramento.where(condicao).in(varios).csearch(@buscando_por).order_by(order_by).page(params[:page]).per(UtilGma.paginacao_relatorio)
    else
      @monitoramentos = Monitoramento.where(condicao).in(varios).order_by(order_by).page(params[:page]).per(UtilGma.paginacao_relatorio)
    end

    params[:titulo] = "Resultado da busca"
    @visor_nome = nil
    @periodo = descricao_periodo(periodo)
    @operador = User.find(busca[:operador]).nome if busca[:operador].present?
    @cameras = descricao_cameras(busca[:cameras])
    render "monitoramentos/relatorios/_relatorio"
  end

  private

  def busca_rapida
    @buscando_por = params[:query]
    @monitoramentos = Monitoramento.search(@buscando_por).page(params[:page]).per(UtilGma.paginacao_relatorio)

    params[:titulo] = "Busca rapida"
    render "monitoramentos/relatorios/_relatorio"
  end

  def descricao_periodo periodos
    return nil if not periodos or periodos.empty? #UtilGma.todos_periodos.keys.join(", ") if not periodos or periodos.empty?
    resp = []
    periodos.each do |p|
      resp << UtilGma.periodo_descricao(p)
    end

    resp.empty? ? UtilGma.todos_periodos.keys.join(", ") : resp.join(", ")
  end

  def descricao_cameras cameras
    return nil if not cameras or cameras.empty?
    cameras = Camera.where.in({:_id => cameras}).order_by([[:nome, :asc]])

    resp = []
    cameras.each do |c|
      resp << c.nome
    end

    resp.empty? ? nil : resp.join(", ")
  end

  def carrega_filtros
    #@ocorrencia_grupos = Ocorrencia.all.order_by([[:grupo, :asc]])
    @operadores = User.all.order_by([[:nome, :asc]])
    #@cameras = Camera.all.order_by([[:nome, :asc]])

    menor_ano = Monitoramento.all.order_by([[:data, :asc]]).limit(1) #traz o monitotamento mais antigo
    menor_ano = !menor_ano.empty? ? menor_ano.first.data.year : Time.now.year
    @anos = ((menor_ano..Time.now.year).to_a) #cria um array do menor ano até o ano atual
  end

end
