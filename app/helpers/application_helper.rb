# encoding: UTF-8
module ApplicationHelper

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

end
