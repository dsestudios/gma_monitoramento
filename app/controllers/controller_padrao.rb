module ControllerPadrao

  #TODO provavelmente existe uma maneira melhor de fazer isso.. mas por enquanto parece a maneira certa.. haha

  # GET
  def respond_to_index(models)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => models }
    end
  end

  # GET
  def respond_to_show(model_class)
    symbol_model = model_class.name.downcase.to_sym
    object_model = model_class.find(params[:id])
    eval("@#{symbol_model} = object_model")  #força a variavel global de mesmo nome do model a recebel o novo object

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => object_model }
      format.json { render :json => object_model }
    end

    object_model
  end

  # GET
  def respond_to_new(model_class_or_object)
    object_model = model_class_or_object

    if model_class_or_object.instance_of? Class
      symbol_model = model_class_or_object.name.downcase.to_sym
      object_model = model_class_or_object.new
      eval("@#{symbol_model} = object_model")  #força a variavel global de mesmo nome do model a recebel o novo object
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => object_model }
    end

    object_model
  end

  # GET
  def respond_to_edit(model_class)
    symbol_model = model_class.name.downcase.to_sym
    object_model = model_class.find(params[:id])
    eval("@#{symbol_model} = object_model")  #força a variavel global de mesmo nome do model a recebel o novo object

    object_model
  end

  # POST
  def respond_to_create(model_class)
    symbol_model = model_class.name.downcase.to_sym
    object_model = model_class.new(params[symbol_model])
    eval("@#{symbol_model} = object_model")  #força a variavel global de mesmo nome do model a recebel o novo object

    respond_to do |format|
      if object_model.save
        format.html { redirect_to([:new, symbol_model], :notice => t("messages.notice.new_registro", :model => model_class.nome_exibicao ) ) }
        format.xml  { render :xml => object_model, :status => :created, :location => object_model }
      else
        format.html { render :action => "new", :location => object_model }
        format.xml  { render :xml => object_model.errors, :status => :unprocessable_entity }
      end
    end

    object_model
  end

  # PUT
  def respond_to_update(model_class)
    symbol_model = model_class.name.downcase.to_sym
    object_model = model_class.find(params[:id])
    eval("@#{symbol_model} = object_model")  #força a variavel global de mesmo nome do model a recebel o novo object

    respond_to do |format|
      if object_model.update_attributes(params[symbol_model])
        format.html { redirect_to( model_class, :notice => t("messages.notice.edit_registro", :model => model_class.nome_exibicao )) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => object_model.errors, :status => :unprocessable_entity }
      end
    end

    object_model
  end

  # DELETE
  def respond_to_destroy(model_class)
    symbol_model = model_class.name.downcase.to_sym
    object_model = model_class.find(params[:id])
    eval("@#{symbol_model} = object_model")  #força a variavel global de mesmo nome do model a recebel o novo object

    object_model.destroy

    respond_to do |format|
      format.html { redirect_to(model_class) }
      format.xml  { head :ok }
    end

    object_model
  end

end