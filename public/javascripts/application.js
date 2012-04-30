function add_field(local_append, model_item, id_padrao, content, maximo_field_vez) {
  if ( maximo_field_vez > -1 ){
      if ( elemento_existe(id_padrao, maximo_field_vez) ){
        return false;
      }
  }

  //Acho que nao ta servindo pra nada
  //var novo_id = "new_" + model_item;
  //var new_id = new Date().getTime();
  //var regexp = new RegExp(novo_id, "g");
  //content = content.replace(regexp, new_id);

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

//function existe(componente) {
    //if ( componente[0] && componente[0].parentNode ) {
//}