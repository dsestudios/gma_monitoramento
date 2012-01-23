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

  def link_to_delete model
    link_to(t("screen.button.destroy"), model, :confirm => t("screen.messages.destroy_registro", :model => model.class.nome_exibicao.downcase), :method => :delete)
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

  def admin_bloco &block
    return "" if !block_given?

    buffer = with_output_buffer { yield }

    return buffer if cannot?(:manager, @user)

    html = <<-HTML
      #{render "admin/menu"}
      <div class="conteudo_admin_scope">
       #{buffer}
      </div>
    HTML

    html.html_safe
  end

  def grid_imagem(array_model, method_imagem, method_titulo, max_column = 4)
    html = <<-HTML
      <script type="text/javascript">
        jQuery(document).ready(function($){
            $('img.borda_arrendondada').imgr({
                radius:'10px'
            });
        });
      </script>
    HTML

    #html << "<div style='clear:both'></div>"
    html << "<table align='center'><tr align='center'><td><div class='celula'>"

    count = 0;
    array_model.each do |m|
      symbol_action = "edit_#{m.class.to_s.downcase}_path".to_sym
      count += 1

      if count == 1
        #html << "<tr align='center' height='150px'>"
        #html << "<div style='clear:both'></div>"
      end

      texto = m.send(method_titulo)
      texto_comprimido = texto.length > 16 ? texto[0,14] + "..." : texto

      html << <<-HTML
        <div class="imageSingle">
            <div class="image">#{link_to(image_tag(m.send(method_imagem, :thumb), :alt => texto, :class => "borda_arrendondada"), send(symbol_action, m)) }</div>
            <div class="footer"><span class="texto1">#{texto_comprimido}</span></div>
            <div class="footer">#{link_to t("screen.button.edit"), send(symbol_action, m) } | #{link_to t("screen.button.destroy"), m, :confirm => t("screen.messages.destroy_registro", :model => m.class.nome_exibicao), :method => :delete }</div>
        </div>
      HTML

      if count == max_column or array_model.last == m
        html << "<div style='clear:both'></div>"
        count = 0
      end

    end

    html << "</div></td></tr></table>"

    html.html_safe
  end

  def grid_imagem_block(array_model, method_imagem, method_titulo, max_column = 4, &block)

    html = <<-HTML
      <script type="text/javascript">
        jQuery(document).ready(function($){
            $('img.borda_arrendondada').imgr({
                radius:'10px'
            });
        });
      </script>
    HTML

    #html << "<div style='clear:both'></div>"
    html << "<table align='center'><tr align='center'><td><div class='celula'>"

    count = 0;
    array_model.each do |m|
      symbol_action = "edit_#{m.class.to_s.downcase}_path".to_sym
      count += 1

      if count == 1
        #html << "<tr align='center' height='150px'>"
        #html << "<div style='clear:both'></div>"
      end

      texto = m.send(method_titulo)
      texto_comprimido = texto.length > 16 ? texto[0,14] + "..." : texto

      buffer = "";
      if block_given?
        buffer = with_output_buffer{yield(m)}
      end

      html << <<-HTML
        <div class="imageSingle">
            <div class="image">#{link_to(image_tag(m.send(method_imagem, :thumb), :alt => texto, :class => "borda_arrendondada"), send(symbol_action, m)) }</div>
            #{buffer}
        </div>
      HTML

      if count == max_column or array_model.last == m
        html << "<div style='clear:both'></div>"
        count = 0
      end

    end

    html << "</div></td></tr></table>"

    html.html_safe
  end

end
