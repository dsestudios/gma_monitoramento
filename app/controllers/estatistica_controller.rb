class EstatisticaController < ApplicationController
  def index
    carrega_filtros
    processa_estatistica

    respond_to do |format|
      format.html
      format.js { render :action => "estatistica/js/tabela_render" }
    end
  end

  def show
    if not processa_estatistica
      flash[:notice] = I18n.t("messages.notice.informa_um_grupo")
    else
      @grupo = @grupo.grupo
    end

    filtros = params[:estatistica]
    @operador = gera_descricao(filtros[:operador], User, :nome)
    @ano = gera_descricao(filtros[:ano])
    @camera = gera_descricao(filtros[:camera], Camera, :nome)

    respond_to do |format|
      format.html do
        render "estatistica/show", :layout=>false
      end
    end
  end

  class ViewResumo
    attr_accessor :descricao, :meses, :total
  end

  private

  def processa_estatistica
    @ocorrencias = []
    @grupo = params[:grupo]

    return false if @grupo.nil? || @grupo.blank?

    @grupo = Ocorrencia.find(@grupo)
    ocorrencias_itens = @grupo.ocorrencia_itens
    @ocorrencias = estatistica_filtrada(ocorrencias_itens, params[:estatistica])
  end

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

  def gera_descricao(valor, class_model=nil, method_descricao=nil)
    if valor.nil? or (valor.blank? or valor[0,1] == "T")
      return "Todos"
    end

    if not class_model or not method_descricao
      return valor
    end

    class_model.find(valor).send(method_descricao)
  end

end
