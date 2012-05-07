#encoding: UTF-8
class MonitoramentosController < ApplicationController
  load_and_authorize_resource
  #before_filter :carrega_dados

  # GET /monitoramentos
  # GET /monitoramentos.xml
  def index

    if params[:prefiltro] == "true"
      @monitores = Visor.all.order_by([[:nome, :asc]])
      respond_to_index(@monitoramentos)
      return
    end

    periodo = params[:periodo]
    mesa = params[:monitor]

    condicao = {}
    condicao[:periodo] = periodo if periodo
    condicao[:visor_id] = mesa if mesa
    order_by = [[:data, :desc], [:data_final, :desc]]

    @periodo = periodo ? Util.periodo_descricao(periodo) : "Todos"
    @visor_nome = mesa ? Visor.find(mesa).nome : "Todos"
    @monitoramentos = Monitoramento.where(condicao).order_by(order_by).page(params[:page]).per(Util.paginacao_relatorio)

    respond_to_index(@monitoramentos)
  end

  # GET /monitoramentos/1
  # GET /monitoramentos/1.xml
  def show
    carrega_dados
    @monitoramento = respond_to_show(Monitoramento)
  end

  # GET /monitoramentos/new
  # GET /monitoramentos/new.xml
  def new
    carrega_dados
    @monitoramento = cria_novo_monitoramento
    if @monitoramento.new_record?
      respond_to_new(@monitoramento)
    else
      redirect_to edit_monitoramento_path(@monitoramento)
    end
  end

  # GET /monitoramentos/1/edit
  def edit
    carrega_dados
    @monitoramento = respond_to_edit(Monitoramento)
  end

  # POST /monitoramentos
  # POST /monitoramentos.xml
  def create

    if action_fluxo("")
      return
    end

    @monitoramento = Monitoramento.find(params[:id])
    @monitoramento.efetivado = true
    respond_to_update(@monitoramento)
  end

  # PUT /monitoramentos/1
  # PUT /monitoramentos/1.xml
  def update

    if action_fluxo("")
      return
    end

    @monitoramento = respond_to_update(Monitoramento, :redirect_success => edit_monitoramento_path(@monitoramento), :notice => t("messages.monitoramento_salvo", :hora => l(Time.now, :format => :time)))
  end

  # DELETE /monitoramentos/1
  # DELETE /monitoramentos/1.xml
  def destroy
    @monitoramento = respond_to_destroy(Monitoramento)
  end

  def remove_ocorrencia
    @monitoramento = Monitoramento.find(params[:id])
    id_ocorrencia = MonitoramentoOcorrencia.find(params[:ocorrencia_id])

    @monitoramento.ocorrencias.delete(id_ocorrencia)
    @monitoramento.save

    render :nothing => true
  end

private

  def set_monitor
    @monitoramento = cria_novo_monitoramento

    if not params[:monitoramento][:visor].blank?
      @monitoramento.save
      @monitoramento.update_attributes(params[:monitoramento])
      redirect_to edit_monitoramento_path(@monitoramento)
    else
      redirect_to new_monitoramento_path
    end

  end

  def add_cameras
    @monitoramento = Monitoramento.find(params[:id])

    parametros = params[:monitoramento]
    if parametros.nil?
      @monitoramento.update_attributes({:camera_ids => []})
    else
      @monitoramento.update_attributes(params[:monitoramento])
    end

    redirect_to edit_monitoramento_path(@monitoramento)
  end

  def add_ocorrencia
    @ocorrencia_item = MonitoramentoOcorrencia.new(params[:ocorrencias])
    @monitoramento = Monitoramento.find(params[:id])
    @monitoramento.ocorrencias << @ocorrencia_item
    @monitoramento.save

    respond_to do |format|
      format.js { render :action => "monitoramentos/ocorrencias/js/add_ocorrencia" }
    end
  end

  def carrega_ocorrencia_itens
    id_ocorrencia = params[:ocorrencia_grupo]
    @itens = OcorrenciaItem.where(:ocorrencia_id => id_ocorrencia).order_by([[:descricao, :asc]]);

    respond_to do |format|
      format.js { render :action => "monitoramentos/ocorrencias/js/carrega_ocorrencia_itens" }
    end
  end

  def carrega_ocorrencia_cameras
    @carrega_cameras = true #indica de deve aparecer o combo com as cameras
    respond_to do |format|
      format.js { render :action => "monitoramentos/ocorrencias/js/carrega_cameras" }
    end
  end

  def carrega_ocorrencia_hora
    @carrega_cameras = true #indica de deve aparecer o combo com as cameras
    respond_to do |format|
      format.js { render :action => "monitoramentos/ocorrencias/js/exibe_hora" }
    end
  end

  def action_fluxo(action)
    return set_monitor if ( params.include?(:set_monitor) )
    return add_cameras if ( params.include?(:add_cameras) )
    return carrega_ocorrencia_itens if ( params.include?(:carrega_ocorrencia_itens) )
    return carrega_ocorrencia_cameras if ( params.include?(:carrega_ocorrencia_cameras) )
    return carrega_ocorrencia_hora if ( params.include?(:carrega_ocorrencia_hora) )
    return add_ocorrencia if ( params.include?(:add_ocorrencia) )

    false
  end

  def carrega_dados
    @cameras_all = Camera.all.order_by([[:nome, :asc]])
    @ocorrencia_all = Ocorrencia.all.order_by([[:grupo, :asc]])
  end

  def cria_novo_monitoramento
    periodo = Util.periodo_atual
    datas = Util.periodo_hora_inicial_e_final(periodo)
    monitoramento = Monitoramento.find(:first, :conditions => {:user_id => current_user.id, :periodo => periodo, :data => datas[:inicio], :data_final => datas[:fim] })

    if monitoramento.nil?
      monitoramento = Monitoramento.new
      monitoramento.user = current_user
      monitoramento.periodo = periodo
      monitoramento.data = datas[:inicio]
      monitoramento.data_final = datas[:fim]
      monitoramento.efetivado = false
      monitoramento.visor = nil
    end

    monitoramento
  end

end