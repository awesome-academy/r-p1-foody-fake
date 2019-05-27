$(document).ready(function(){
  for (let i = 0; i < $('.minus').length; i++){
    $($('.minus')[i]).click( function() {
      current_value = get_quantity($('.minus')[i]);
      current_value -= 1;
      set_quantity($('.minus')[i], current_value);
    });
  }

  for (let i = 0; i < $('.add').length; i++){
    $($('.add')[i]).click( function() {
      current_value = get_quantity($('.add')[i]);
      current_value += 1;
      set_quantity($('.add')[i], current_value);
    });
  }
})

function get_quantity(element){
  return parseInt($(element).parent().find('input')[0].value)
}

function set_quantity(element, value) {
  $(element).parent().find('input')[0].value = value.toString();
}
