class AdminController < ApplicationController

  def index
    authorize! :manager, :all #TODO ver a melhor forma de fazer isso
  end

end
