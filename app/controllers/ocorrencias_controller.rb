# encoding: UTF-8
class OcorrenciasController < ApplicationController
  load_and_authorize_resource

  # GET /ocorrencias
  # GET /ocorrencias.xml
  def index
    @ocorrencias = Ocorrencia.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ocorrencias }
    end
  end

  # GET /ocorrencias/1
  # GET /ocorrencias/1.xml
  def show
    @ocorrencia = Ocorrencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ocorrencia }
    end
  end

  # GET /ocorrencias/new
  # GET /ocorrencias/new.xml
  def new
    @ocorrencia = Ocorrencia.new
    @ocorrencia.ocorrencia_itens.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ocorrencia }
    end
  end

  # GET /ocorrencias/1/edit
  def edit
    @ocorrencia = Ocorrencia.find(params[:id])
  end

  # POST /ocorrencias
  # POST /ocorrencias.xml
  def create
    @ocorrencia = Ocorrencia.new(params[:ocorrencia])
    respond_to do |format|
      if @ocorrencia.save
        format.html { redirect_to(@ocorrencia, :notice => t("messages.notice.new_registro", :model => "Ocorrência") ) }
        format.xml  { render :xml => @ocorrencia, :status => :created, :location => @ocorrencia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ocorrencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ocorrencias/1
  # PUT /ocorrencias/1.xml
  def update
    @ocorrencia = Ocorrencia.find(params[:id])
    @ocorrencia.ocorrencia_itens.delete_all if !params[:ocorrencia].include?('ocorrencia_itens_attributes')

    respond_to do |format|
      if @ocorrencia.update_attributes(params[:ocorrencia])
        format.html { redirect_to(@ocorrencia, :notice => t("messages.notice.edit_registro", :model => "Ocorrência")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ocorrencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ocorrencias/1
  # DELETE /ocorrencias/1.xml
  def destroy
    @ocorrencia = Ocorrencia.find(params[:id])
    @ocorrencia.destroy

    respond_to do |format|
      format.html { redirect_to(ocorrencias_url) }
      format.xml  { head :ok }
    end
  end
end
