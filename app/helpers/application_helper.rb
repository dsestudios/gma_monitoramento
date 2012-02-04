# encoding: UTF-8
module ApplicationHelper
  include FormTagsStandard

  # Retorna o campo SELECT com todos os tipos de usuário
  # param form = formulario da view
  # param method = Nome do campo que devera receber o dado selecionado => Default = :role
  # param label = Titulo do campo => Default = 'Tipo de usuário'
  def select_tipo_de_usuario(form, method = :role, label = 'Tipo de usuário')
    html = <<-HTML
    <div>#{form.label(label)}
    #{form.select method, Ability.tipos_de_usuarios.collect{|k,v| [v,k]} }</div>
    HTML

    html.html_safe
  end

  # Retorna o campo para selecionar uma imagem para upload
  # param form = formulario da view
  # param user = Model que recebera a imagem
  # param method = Symbol do campo do model que armazena a imagem
  def seleciona_imagem(form, model, method)
    html = <<-HTML
    <table>
     <tr>
      <td>
       <p>#{image_tag model.send(method, :thumb) }</p>
      </td>
      <td>
       #{form.input method, :as => :file }
      </td>
    </tr>
    </table>
    HTML

    html.html_safe
  end

  def link_to_remove_field(label_link, form, local)
    local = "this" if local.blank?
    form.input(:_destroy, :as => :hidden ) + link_to_function(label_link, "remove_field(this, #{local})")
  end

  def link_to_remove_field_novo(label_link, local, nome_array, object_id)
    local = "this" if local.blank?
    "<div><div style='display: none;'>#{check_box_tag(nome_array, object_id, true)}</div> #{link_to_function(label_link, "remove_field_novo(this, #{local})")}</div>".html_safe
  end

  def link_to_add_field(descricao_link, form, model_item_sym, partial, local_append = "", classCSS = "", usaFormPai = true, args = {} )
    maximo_fields_por_vez = args[:fields_por_vez] == nil ? -1 : args[:fields_por_vez]

    local_append = "##{model_item_sym}" if local_append.blank?
    new_object = form.object.class.reflect_on_association(model_item_sym).klass.new

    formPai = form
    if !usaFormPai
      formPai = self
    end

    id_padrao = "new_#{model_item_sym.to_s.singularize}"

    new_field = formPai.simple_fields_for(model_item_sym, new_object, :child_index => "new_#{model_item_sym}") do |builder|
      render(partial, :f => builder)
    end
    link_to_function(descricao_link, "add_field( '#{local_append}', '#{model_item_sym}', '#{id_padrao}', '#{escape_javascript(new_field)}', '#{maximo_fields_por_vez}' )", :class => classCSS)
  end

  def saudacao
    return "" if not user_signed_in?
    "Olá, #{link_to(current_user.nome, edit_user_path(current_user))}".html_safe
  end

  def action_new?
    params[:action] == :new.to_s or params[:action] == :create.to_s
  end

  def action_edit?
    params[:action] == :edit.to_s or params[:action] == :update.to_s
  end

  def action_index?
    params[:action] == :index.to_s
  end

  def action_show?
    params[:action] == :show.to_s
  end

end
