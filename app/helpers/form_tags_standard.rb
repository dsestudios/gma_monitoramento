# encoding: UTF-8
module FormTagsStandard

  def titulo valor
    params[:titulo] = valor
    "<h1>#{valor}</h1>".html_safe
  end

  def link_to_back local=""
    link_to(t("screen.button.back"), local.blank? ? :back : local)
  end

end
