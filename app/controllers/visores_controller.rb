class VisoresController < ApplicationController
  load_and_authorize_resource

  # GET /visores
  # GET /visores.xml
  def index
    @visores = Visor.all.order_by([[:nome, :asc]])
    respond_to_index(@visores)
  end

  # GET /visores/1
  # GET /visores/1.xml
  def show
    @visor = respond_to_show(Visor)
  end

  # GET /visores/new
  # GET /visores/new.xml
  def new
    @visor = respond_to_new(Visor)
  end

  # GET /visores/1/edit
  def edit
    @visor = respond_to_edit(Visor)
  end

  # POST /visores
  # POST /visores.xml
  def create
    @visor = respond_to_create(Visor)
  end

  # PUT /visores/1
  # PUT /visores/1.xml
  def update
    params[:visor][:cameras_fixa_ids] ||= {}
    @visor = respond_to_update(Visor)
  end

  # DELETE /visores/1
  # DELETE /visores/1.xml
  def destroy
    @visor = respond_to_destroy(Visor)
  end
end
