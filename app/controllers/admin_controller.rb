class AdminController < ApplicationController

  def index
    authorize! :manage, :all #TODO ver a melhor forma de fazer isso
  end

end
