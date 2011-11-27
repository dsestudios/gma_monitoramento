class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash.notice = I18n.t("messages.notice.acesso_negado")
    redirect_to root_path
  end
end
