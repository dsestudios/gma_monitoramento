class BuscaController < ApplicationController
  def index
    return resultado if params[:commit]
  end

  def resultado
    busca = params[:busca]
    periodo = busca[:periodo]
    periodo.delete("")

    #TODO arrumar isso.. ver pq a data nao vem concatenada em um unico campo (multiparam)
    @periodo_inicial = busca["periodo_inicial(3i)"] + "/" + busca["periodo_inicial(2i)"] + "/" + busca["periodo_inicial(1i)"]
    @periodo_final = busca["periodo_final(3i)"] + "/" + busca["periodo_final(2i)"] + "/" + busca["periodo_final(1i)"]

    condicao = { :data.gte => @periodo_inicial, :data.lte => @periodo_final }
    varios = {}
    varios[:periodo] = periodo if not periodo.empty?
    varios[:camera_ids] = busca[:cameras] if busca[:cameras]

    order_by = [[:data, :asc], [:data_final, :asc]]
    @monitoramentos = Monitoramento.where(condicao).in(varios).order_by(order_by).page(params[:page]).per(Util.paginacao_relatorio)

    params[:titulo] = "Resultado da busca"
    @visor_nome = "Todas"
    @periodo = descricao_periodo(periodo)
    @cameras = descricao_cameras(busca[:cameras])
    render "monitoramentos/relatorios/_relatorio"
  end

  private

  def descricao_periodo periodos
    return Util.todos_periodos.keys.join(", ") if not periodos or periodos.empty?
    resp = []
    periodos.each do |p|
      resp << Util.periodo_descricao(p)
    end

    resp.empty? ? Util.todos_periodos.keys.join(", ") : resp.join(", ")
  end

  def descricao_cameras cameras
    return "Todas" if not cameras or cameras.empty?
    cameras = Camera.where.in({:_id => cameras}).order_by([[:nome, :asc]])

    resp = []
    cameras.each do |c|
      resp << c.nome
    end

    resp.empty? ? "Todas" : resp.join(", ")
  end

end
