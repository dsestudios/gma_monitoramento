module OcorrenciasHelper

  def add_item_link(name)
    link_to name, '#', :class => "add_item"
  end

end
