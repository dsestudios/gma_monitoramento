class <%= controller_class_name %>Controller < ApplicationController
  load_and_authorize_resource

  # GET <%= route_url %>
  # GET <%= route_url %>.xml
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_to_index(@<%= plural_table_name %>)
  end

  # GET <%= route_url %>/1
  # GET <%= route_url %>/1.xml
  def show
    @<%= singular_table_name %> = respond_to_show(<%= class_name %>)
  end

  # GET <%= route_url %>/new
  # GET <%= route_url %>/new.xml
  def new
    @<%= singular_table_name %> = respond_to_new(<%= class_name %>)
  end

  # GET <%= route_url %>/1/edit
  def edit
    @<%= singular_table_name %> = respond_to_edit(<%= class_name %>)
  end

  # POST <%= route_url %>
  # POST <%= route_url %>.xml
  def create
    @<%= singular_table_name %> = respond_to_create(<%= class_name %>)
  end

  # PUT <%= route_url %>/1
  # PUT <%= route_url %>/1.xml
  def update
    @<%= singular_table_name %> = respond_to_update(<%= class_name %>)
  end

  # DELETE <%= route_url %>/1
  # DELETE <%= route_url %>/1.xml
  def destroy
    @<%= singular_table_name %> = respond_to_destroy(<%= class_name %>)
  end

end