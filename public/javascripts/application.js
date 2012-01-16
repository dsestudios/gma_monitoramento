function add_field(local_append, model_item, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + model_item, "g");
  content = content.replace(regexp, new_id);
  $(local_append).append(content);
  return false;
}

function remove_field(local) {
  $(local).parent().hide();
  $(local).prev().attr("value", "1");
}