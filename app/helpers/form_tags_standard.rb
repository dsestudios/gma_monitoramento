# encoding: UTF-8
module FormTagsStandard

  def titulo valor
    params[:titulo] = valor
  end

  def auto_titulo
    return params[:titulo] if !params[:titulo].blank?

    action = params[:action]
    controller = params[:controller]
    return "" if action.blank? or controller.blank?

    tag = action == "index" ? "plural" : "singular"
    valor = I18n.t("models_display_names.#{controller.singularize.downcase}.#{tag}", :default => controller).capitalize
    valor << " - " + I18n.t("screen.button.#{action}", :default => action).capitalize if action != "index"

    valor
  end

  def link_to_back local=""
    link_to(t("screen.button.back"), local.blank? ? :back : local)
  end

  def link_label_to(*args, &block)
    hash_values = {}
    args.each do |a|
      if a.instance_of? Hash
        hash_values = a
        break;
      end
    end
    args.delete_one(hash_values)
    hash_values[:class] = "link_label"
    args << hash_values
    "<span class='label_app'>#{link_to(*args, &block)}</span>".html_safe
  end

end
