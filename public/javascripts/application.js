function add_field(local_append, model_item, id_padrao, content, maximo_field_vez) {
  if ( maximo_field_vez > -1 ){
      if ( elemento_existe(id_padrao, maximo_field_vez) ){
        return false;
      }
  }

  //Acho que nao ta servindo pra nada
  var novo_id = "new_" + model_item;
  var new_id = new Date().getTime();
  var regexp = new RegExp(novo_id, "g");
  content = content.replace(regexp, new_id);

  $(local_append).append(content);

  return false;
}

function remove_field(eu, local) {
   if (local == eu){
       return remove_field1(eu, local);
   }
  var campoPai = $(eu).closest(local);
  campoPai.attr( "id", campoPai.attr('id') + '_removido');
  campoPai.fadeOut();
  $(eu).prev().attr("value", "1");
}


function remove_field1(eu, local) {
  var campoPai = $(local).parent();
  campoPai.attr( "id", campoPai.attr('id') + '_removido');
  campoPai.fadeOut();
  $(local).prev().attr("value", "1");
}

function remove_field_novo(eu, local) {
  var campoPai = $(eu).closest(local);
  campoPai.attr( "id", campoPai.attr('id') + '_removido');
  campoPai.fadeOut();
  $(eu).prev().children().attr("value", "0");
  $(eu).prev().children().removeAttr("checked");
}

function div_dialog( id_div ){
   $(document).ready(function(){
	  $('#'+id_div).hide();

      $('a#'+id_div+'_exibir_div').click(function(){
		    $('#'+id_div).show('slow');
   	  });

      $('#'+id_div + ' a#ocultar_div').click(function(){
       		$('#'+id_div).hide('slow');
      });
   });
}

function executa_click(nome_link_ou_botao){
    $(nome_link_ou_botao).trigger('click');
}

function elemento_existe(id, qtde_max){
  return $('#'+id).length >= qtde_max;
}

/**
 * Gerar parametros (nome=valor) de todos os componentes do tipo informado
 *
 * @param _form = Nome dos forms que estão os componentes
 * @return {String}
 */
function getComponentTypeParameters(_form, _componentType){
    var form = document.getElementById(_form);
    var inputs = form.getElementsByTagName(_componentType);

    var dados = '';
    for( var i=0; i<inputs.length; i++ ){
        dados += inputs[i].name+'='+inputs[i].value+'&';
    }
    return dados;
}

/**
 * Gerar parametros (nome=valor) de todos os campos
 *
 * @param _form = Nome dos forms que estão os campos
 * @return {String}
 */
function getParametros(_form){
    return '?'+getComponentTypeParameters(_form,'input')+getComponentTypeParameters(_form,'textarea')+getComponentTypeParameters(_form, 'select');
}

function link_submit(field_link, form_submit){
    var link_original = $(field_link).attr("link_original");
    if (link_original == null || link_original == undefined){
        link_original = $(field_link).attr("href")
        $(field_link).attr("link_original", link_original );
    }

    $(field_link).attr("href", link_original + getParametros(form_submit));
}
