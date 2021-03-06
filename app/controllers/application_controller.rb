class ApplicationController < ActionController::Base
  include ControllerPadrao

  protect_from_forgery

  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash.notice = I18n.t("messages.notice.acesso_negado")

    begin
      redirect_to :back
    rescue Exception => e
      redirect_to root_path
    end

  end

  #Metodo sobrescrito do Devise para manipular o fluxo apos fazer o login
  def after_sign_in_path_for(resource_or_scope)
    session[:user_admin] = can?(:manager, :all)
    root_path
  end

#  def redirect_to(options = {}, response_status = {})
#    if request.xhr?
#      render(:update) {|page| page.redirect_to(options)}
#    else
#      super(options, response_status)
#    end
#  end

end
