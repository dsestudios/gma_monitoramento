class MonitoramentosController < ApplicationController
  load_and_authorize_resource

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
    @monitoramento = Monitoramento.find(params[:id])
    @monitoramento.efetivado = true
    respond_to_update(@monitoramento)
  end

  # PUT /monitoramentos/1
  # PUT /monitoramentos/1.xml
  def update
    @monitoramento = respond_to_update(Monitoramento)
  end

  # DELETE /monitoramentos/1
  # DELETE /monitoramentos/1.xml
  def destroy
    @monitoramento = respond_to_destroy(Monitoramento)
  end

  def add_cameras
    @monitoramento = Monitoramento.find(params[:id])

    if params[:monitoramento].nil?
      @monitoramento.update_attributes({:camera_ids => []})
    else
      @monitoramento.update_attributes(params[:monitoramento])
    end

    redirect_to new_monitoramento_path
  end

end