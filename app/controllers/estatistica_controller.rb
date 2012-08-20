class EstatisticaController < ApplicationController
  def index
    carrega_filtros

    @ocorrencias = []
    grupo = params[:grupo]

    if grupo
      ocorrencias_itens = Ocorrencia.find(grupo).ocorrencia_itens
      @ocorrencias = estatistica_filtrada(ocorrencias_itens, params[:estatistica])
    end

    respond_to do |format|
      format.html
      format.js { render :action => "estatistica/js/tabela_render" }
    end

  end

  def show

  end

  class ViewResumo
    attr_accessor :descricao, :meses, :total
  end

  private

  def estatistica_filtrada(ocorrencia_itens, filtros)
    meses_total = {}
    13.times do |i|
      meses_total[i+1] = 0;
    end

    estatistica = []
    ocorrencia_itens.each do |i|
      vr = ViewResumo.new
      vr.descricao= i.descricao
      vr.meses= i.quantidade_ocorrencia_todos_meses(ano: filtros[:ano], camera: filtros[:camera], operador: filtros[:operador])
      vr.meses[13]= vr.meses.values.sum

      vr.meses.each do |k,v|
        meses_total[k] += v
      end
      estatistica << vr
    end

    vr = ViewResumo.new
    vr.descricao= "TOTAL"
    vr.meses= meses_total
    #vr.meses[13]= meses_total.values.sum
    estatistica << vr

    estatistica
  end

  def carrega_filtros
    @ocorrencia_grupos = Ocorrencia.all.order_by([[:grupo, :asc]])
    @operadores = User.all.order_by([[:nome, :asc]])
    @cameras = Camera.all.order_by([[:nome, :asc]])

    menor_ano = Monitoramento.all.order_by([[:data, :asc]]).limit(1) #traz o monitotamento mais antigo
    menor_ano = !menor_ano.empty? ? menor_ano.first.data.year : Time.now.year
    @anos = ((menor_ano..Time.now.year).to_a) #cria um array do menor ano até o ano atual
  end

end
