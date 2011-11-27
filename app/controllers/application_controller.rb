class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash.notice = 'Voce nao pode acessar esta area'
    redirect_to root_url
  end
end
