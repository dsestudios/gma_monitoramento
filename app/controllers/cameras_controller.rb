class CamerasController < ApplicationController
  load_and_authorize_resource

  # GET
  def index
    @cameras = Camera.all.order_by([[:nome, :asc]])
    respond_to_index(@cameras)
  end

  # GET /cameras/1
  # GET /cameras/1.xml
  def show
    @camera = respond_to_show(Camera)
  end

  # GET /cameras/new
  # GET /cameras/new.xml
  def new
    @camera = respond_to_new(Camera)
  end

  # GET /cameras/1/edit
  def edit
    @camera = respond_to_edit(Camera)
  end

  # POST /cameras
  # POST /cameras.xml
  def create
    @camera = respond_to_create(Camera)
  end

  # PUT /cameras/1
  # PUT /cameras/1.xml
  def update
    @camera = respond_to_update(Camera)
  end

  # DELETE /cameras/1
  # DELETE /cameras/1.xml
  def destroy
    @camera = respond_to_destroy(Camera)
  end
end
