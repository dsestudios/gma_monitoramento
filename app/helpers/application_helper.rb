# encoding: UTF-8
module ApplicationHelper
  include FormTagsStandard

  # Retorna o campo SELECT com todos os tipos de usuário
  # param form = formulario da view
  # param method = Nome do campo que devera receber o dado selecionado => Default = :role
  # param label = Titulo do campo => Default = 'Tipo de usuário'
  def select_tipo_de_usuario(form, method = :role, label = 'Tipo de usuário')
    html = <<-HTML
    <div>#{form.label(label)}<br />
    #{form.select method, Ability.tipos_de_usuarios.collect{|k,v| [v,k]} }</div>
    HTML

    html.html_safe
  end

  # Retorna o campo Campo para selecionar a imagem do perfil do usuário
  # param form = formulario da view
  # param user = Model do user
  def seleciona_imagem_perfil(form, user)
    html = <<-HTML
    <table>
     <tr>
      <td>
       <p>#{image_tag user.avatar(:thumb)}</p>
      </td>
      <td>
       #{form.input :avatar, :as => :file, :label => "Selecione uma imagem do perfil" }
      </td>
    </tr>
    </table>
    HTML

    html.html_safe
  end

  def link_to_remove_fields(name, f)
    f.input(:_destroy, :as => :hidden ) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, partial)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(partial, :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
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

end
