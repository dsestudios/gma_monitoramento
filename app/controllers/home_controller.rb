#encoding: UTF-8

class HomeController < ApplicationController

  def index
    @user = current_user
    @ocorrencias_count = 0
    @user.monitoramentos.each{|m| @ocorrencias_count += m.ocorrencias.count}

    #TODO fazer DRY com o MODEL do monitoramento
    periodo = Util.periodo_atual
    datas = Util.periodo_hora_inicial_e_final(periodo)
    monitoramento = Monitoramento.find(:first, :conditions => {:user_id => current_user.id, :periodo => periodo, :data => datas[:inicio], :data_final => datas[:fim] })
    if monitoramento && monitoramento.visor
      @monitoramento_nao_finalizado = monitoramento
    end

  end

  def meus_monitoramentos
    order_by = [[:data, :asc], [:data_final, :asc]]

    @periodo = "Todos"
    @visor_nome = "Todos"
    @monitoramentos = Monitoramento.where(:user_id => current_user.id).order_by(order_by)

    params[:titulo] = "Meus monitoramentos"
    render "monitoramentos/relatorios/_relatorio"
  end

end
