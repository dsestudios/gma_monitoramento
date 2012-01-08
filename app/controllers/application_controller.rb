class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash.notice = I18n.t("messages.notice.acesso_negado")
    redirect_to root_path
  end

  #Metodo sobrescrito do Devise para manipular o fluxo apos fazer o login
  def after_sign_in_path_for(resource_or_scope)
    session[:user_admin] = can?(:manager, :all)
    root_path
  end

end
