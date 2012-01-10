class VisoresController < ApplicationController
  load_and_authorize_resource

  # GET /visores
  # GET /visores.xml
  def index
    @visores = Visor.all.order_by([[:nome, :asc]])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @visores }
    end
  end

  # GET /visores/1
  # GET /visores/1.xml
  def show
    @visor = Visor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @visor }
    end
  end

  # GET /visores/new
  # GET /visores/new.xml
  def new
    @visor = Visor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @visor }
    end
  end

  # GET /visores/1/edit
  def edit
    @visor = Visor.find(params[:id])
  end

  # POST /visores
  # POST /visores.xml
  def create
    @visor = Visor.new(params[:visor])

    respond_to do |format|
      if @visor.save
        format.html { redirect_to(@visor, :notice => t("messages.notice.new_registro", :model => Visor.nome_exibicao ) ) }
        format.xml  { render :xml => @visor, :status => :created, :location => @visor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /visores/1
  # PUT /visores/1.xml
  def update
    @visor = Visor.find(params[:id])

    respond_to do |format|
      if @visor.update_attributes(params[:visor])
        format.html { redirect_to(visores_path, :notice => t("messages.notice.edit_registro", :model => Visor.nome_exibicao )) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @visor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /visores/1
  # DELETE /visores/1.xml
  def destroy
    @visor = Visor.find(params[:id])
    @visor.destroy

    respond_to do |format|
      format.html { redirect_to(visores_url) }
      format.xml  { head :ok }
    end
  end
end
