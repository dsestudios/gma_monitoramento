# encoding: UTF-8
module FormTagsStandard

  def titulo valor
    "<h1>#{valor}</h1>".html_safe
  end

  def link_to_back
    link_to(t("screen.button.back"), :back).html_safe?
  end

  def add_fields *fields_str
    add( "<p>", "</p>", *fields_str )
  end

  def add_fields_no_tags *fields_str
    add( "", "", *fields_str )
  end

  def add tag_ini = "", tag_fim = "", *fields_str
    html = tag_ini
    fields_str.each do |f|
      html << " #{f}"
    end
    html << tag_fim

    html.html_safe
  end

end
