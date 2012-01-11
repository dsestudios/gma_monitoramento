# encoding: UTF-8
class OcorrenciasController < ApplicationController
  load_and_authorize_resource

  # GET /ocorrencias
  # GET /ocorrencias.xml
  def index
    @ocorrencias = Ocorrencia.all
    respond_to_index(@ocorrencias)
  end

  # GET /ocorrencias/1
  # GET /ocorrencias/1.xml
  def show
    @ocorrencia = respond_to_show(Ocorrencia)
  end

  # GET /ocorrencias/new
  # GET /ocorrencias/new.xml
  def new
    @ocorrencia = Ocorrencia.new
    @ocorrencia.ocorrencia_itens.build

    respond_to_new(@ocorrencia)
  end

  # GET /ocorrencias/1/edit
  def edit
    @ocorrencia = respond_to_edit(Ocorrencia)
  end

  # POST /ocorrencias
  # POST /ocorrencias.xml
  def create
    @ocorrencia = respond_to_create(Ocorrencia)
  end

  # PUT /ocorrencias/1
  # PUT /ocorrencias/1.xml
  def update
    @ocorrencia = respond_to_update(Ocorrencia)
  end

  # DELETE /ocorrencias/1
  # DELETE /ocorrencias/1.xml
  def destroy
    @ocorrencia = respond_to_destroy(Ocorrencia)
  end
end
