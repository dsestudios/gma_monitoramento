# encoding: UTF-8
class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all.order_by([[:nome, :asc]])
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
    respond_to_create(@user, users_path)
  end

  def update
    @user = User.find(params[:id])

    seguranca_trata_campos

    respond_to do |format|
      salvou = can?(:manage, :all) ? @user.update_attributes(params[:user]) : @user.update_with_password(params[:user])
      if salvou
        format.html { redirect_to(root_path, :notice => t("messages.notice.edit_registro", :model => User.nome_exibicao)) }
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
    valores = params[:user]
    if valores[:password].blank?
      valores.delete(:password)
      valores.delete(:password_confirmation.to_s) if valores[:password_confirmation.to_s].blank?
    end

    #Se não pode alterar
    if cannot? :manager, @user
      valores.delete(:role)
      valores.delete(:nome_usuario)
    end

  end

end
