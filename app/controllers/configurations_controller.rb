class ConfigurationsController < ApplicationController
  load_and_authorize_resource

  # GET /configurations
  # GET /configurations.xml
  def index
    @configurations = Configuration.all
    respond_to_index(@configurations)
  end

  # GET /configurations/1
  # GET /configurations/1.xml
  def show
    @configuration = respond_to_show(Configuration)
  end

  # GET /configurations/new
  # GET /configurations/new.xml
  def new
    @configuration = respond_to_new(Configuration)
  end

  # GET /configurations/1/edit
  def edit
    @configuration = respond_to_edit(Configuration)
  end

  # POST /configurations
  # POST /configurations.xml
  def create
    @configuration = respond_to_create(Configuration)
  end

  # PUT /configurations/1
  # PUT /configurations/1.xml
  def update
    @configuration = respond_to_update(Configuration)
  end

  # DELETE /configurations/1
  # DELETE /configurations/1.xml
  def destroy
    #Não deve permitir excluir uma configuração
    #@configuration = respond_to_destroy(Configuration)
  end

end