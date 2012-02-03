function add_field(local_append, model_item, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + model_item, "g");
  content = content.replace(regexp, new_id);
  $(local_append).append(content);
  return false;
}

function remove_field(eu, local) {
   if (local == eu){
       return remove_field1(eu, local);
   }
  $(eu).closest(local).fadeOut();
  $(eu).prev().attr("value", "1");
}


function remove_field1(eu, local) {
  $(local).parent().fadeOut();
  $(local).prev().attr("value", "1");
}

function remove_field_novo(eu, local) {
  $(eu).closest(local).fadeOut();
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