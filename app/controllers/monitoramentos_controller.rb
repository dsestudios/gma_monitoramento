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
    @monitoramento = Monitoramento.find(:first, :conditions => {:user_id => current_user.id, :periodo => Util.periodo_atual, :data => Time.now })

    if @monitoramento.nil?
      @monitoramento = Monitoramento.new
      @monitoramento.user = current_user
      @monitoramento.periodo = Util.periodo_atual
      @monitoramento.data = Time.now
      @monitoramento.efetivado = false
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


    if params[:commit] == "OK"
      return add_cameras
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

  def add_cameras
    @monitoramento = Monitoramento.find(params[:id])

    parametros = params[:monitoramento]

    if parametros.nil?
      @monitoramento.update_attributes({:camera_ids => []})
    else
      @monitoramento.update_attributes(params[:monitoramento])
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
   # @monitoramento.update_attributes(params[:monitoramento])
    @monitoramento.save

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