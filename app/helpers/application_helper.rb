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
       <div>#{form.label 'Selecione uma imagem do perfil'}<br />
       #{form.file_field :avatar}</div>
      </td>
    </tr>
    </table>
    HTML

    html.html_safe
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, partial = "")
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      partial = association.to_s.singularize + "_fields" if partial.blank?
      render(partial, :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end
