# encoding: UTF-8
class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    seguranca_trata_campos

    respond_to do |format|
      if @user.save
        format.html { redirect_to(users_path, :notice => t("messages.notice.new_registro", :model => "Usuário") ) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    seguranca_trata_campos

    respond_to do |format|
      if @user.update_with_password(params[:user])
        format.html { redirect_to(root_path, :notice => t("messages.notice.edit_registro", :model => "Usuário")) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.xml  { head :ok }
    end
  end

  private

  def seguranca_trata_campos
    #Se não pode alterar
    if cannot? :manager, @user
      params[:user].delete(:role)
      params[:user].delete(:nome_usuario)
    end

  end

end
