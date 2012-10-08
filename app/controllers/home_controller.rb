#encoding: UTF-8

class HomeController < ApplicationController

  def index
    @user = current_user
    @ocorrencias_count = 0
    @user.monitoramentos.each{|m| @ocorrencias_count += m.ocorrencias.count}

    #TODO fazer DRY com o MODEL do monitoramento
    periodo = UtilGma.periodo_atual
    datas = UtilGma.periodo_hora_inicial_e_final(periodo)
    monitoramento = Monitoramento.find(:first, :conditions => {:user_id => current_user.id, :periodo => periodo, :data => datas[:inicio], :data_final => datas[:fim] })
    if monitoramento && monitoramento.visor
      @monitoramento_nao_finalizado = monitoramento
    end

  end

  def meus_monitoramentos
    order_by = [[:data, :asc], [:data_final, :asc]]
    condicao = {:user_id => current_user.id}

    @periodo = "Todos"
    @visor_nome = "Todos"
    @monitoramentos = Monitoramento.where(condicao).order_by(order_by).page(params[:page]).per(UtilGma.paginacao_relatorio)

    params[:titulo] = "Meus monitoramentos"
    render "monitoramentos/relatorios/_relatorio"
  end

end
