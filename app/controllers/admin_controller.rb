class AdminController < ApplicationController

  def index
    authorize! :manage, :all #TODO ver a melhor forma de fazer isso

    @user = current_user
    @ocorrencias_count = 0
    @user.monitoramentos.each{|m| @ocorrencias_count += m.ocorrencias.count}
  end

end
