class MonitoramentosController < ApplicationController
  load_and_authorize_resource
  before_filter :carrega_dados

  # GET /monitoramentos
  # GET /monitoramentos.xml
  def index
    @monitoramentos = Monitoramento.all
    respond_to_index(@monitoramentos)
  end

  # GET /monitoramentos/1
  # GET /monitoramentos/1.xml
  def show
    @monitoramento = respond_to_show(Monitoramento)
  end

  # GET /monitoramentos/new
  # GET /monitoramentos/new.xml
  def new
    periodo = Util.periodo_atual
    datas = Util.periodo_hora_inicial_e_final(periodo)
    @monitoramento = Monitoramento.find(:first, :conditions => {:user_id => current_user.id, :periodo => periodo, :data => datas[:inicio], :data_final => datas[:fim] })

    if @monitoramento.nil?
      @monitoramento = Monitoramento.new
      @monitoramento.user = current_user
      @monitoramento.periodo = periodo
      @monitoramento.data = datas[:inicio]
      @monitoramento.data_final = datas[:fim]
      @monitoramento.efetivado = false
      @monitoramento.visor = nil
      @monitoramento.save
    end

    respond_to_new(@monitoramento)
  end

  # GET /monitoramentos/1/edit
  def edit
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

    @monitoramento = respond_to_update(Monitoramento)
  end

  # DELETE /monitoramentos/1
  # DELETE /monitoramentos/1.xml
  def destroy
    @monitoramento = respond_to_destroy(Monitoramento)
  end

private

  def set_monitor
    @monitoramento = Monitoramento.find(params[:id])
    if !@monitoramento.update_attributes(params[:monitoramento])
      @erro = @monitoramento.errors.to_s
    end

    redirect_to new_monitoramento_path
  end

  def add_cameras
    @monitoramento = Monitoramento.find(params[:id])

    parametros = params[:monitoramento]

    if parametros.nil?
      if !@monitoramento.update_attributes({:camera_ids => []})
        @erro = @monitoramento.errors.to_s
      end
    else
      if !@monitoramento.update_attributes(params[:monitoramento])
        @erro = @monitoramento.errors.to_s
      end
    end

    #respond_to do |format|
    #  format.js { render :action => "add_cameras" }
    #end

    redirect_to new_monitoramento_path
  end

  def add_ocorrencia
    @monitoramento = Monitoramento.find(params[:id])
    @ocorrencia_itens = OcorrenciaItem.find(params[:ocorrencia_itens][:descricao])
    @itens = @ocorrencia_itens.ocorrencia.ocorrencia_itens
    @monitoramento.ocorrencia_itens << @ocorrencia_itens
    if !@monitoramento.save
      @erro = @monitoramento.errors.to_s
    end

    respond_to do |format|
      format.js { render :action => "add_ocorrencia" }
    end
  end

  def carrega_ocorrencia_itens
    @monitoramento = Monitoramento.find(params[:id])
    id_ocorrencia = params[:ocorrencia_itens][:ocorrencia]
    @itens = Ocorrencia.find(id_ocorrencia).ocorrencia_itens
    @ocorrencia_itens = OcorrenciaItem.new

    respond_to do |format|
      format.js { render :action => "carrega_ocorrencia_itens" }
    end
  end

  def action_fluxo(action)
    return set_monitor if ( params.include?(:set_monitor) )
    return add_cameras if ( params.include?(:add_cameras) )
    return carrega_ocorrencia_itens if ( params.include?(:carrega_ocorrencia_itens) )
    return add_ocorrencia if ( params.include?(:add_ocorrencia) )

    false
  end

  def carrega_dados
    @cameras_all = Camera.all
    @ocorrencia_all = Ocorrencia.all
  end

end