$(document).ready(function() {

  DOMAIN_API = 'http://localhost:3000/'
  DEFAULT_TEXT_DISTRICT_SELECT = I18n.t("select_district")
  DEFAULT_TEXT_WARD_SELECT = I18n.t("select_ward")

  $('#province_select').on('focus', setIndex())
  $('#district_select').on('focus', setIndex())



  $('#province_select').on('change', function() {
    var selfs = this;
    $.ajax({url: DOMAIN_API + 'searchdistrict?provinceid=' + selfs.value,
      success: function(result){
        onResult($('#district_select'), $('#ward_select'), result, DEFAULT_TEXT_DISTRICT_SELECT)
    }});
  });

  $('#district_select').on('change', function() {
    var selfs = this;
    $.ajax({url: DOMAIN_API+ 'searchward?districtid=' + selfs.value,
      success: function(result){
        onResult($('#ward_select'), null , result, DEFAULT_TEXT_WARD_SELECT)
      }
    });
  })
})

function setIndex() {
  this.selectedIndex = -1
}

function creatOptions(parentElement, result, textValue=null, value=null) {
  if(textValue) {
     setOption(parentElement, value, textValue)
  }
  else {
    for(let key in result){
      setOption(parentElement, result[key], key)
    }
  }
}

function setOption(parentElement, value, text) {
  var option = $('<option/>');
  option.attr({ 'value': value }).text(text);
  parentElement.append(option);
}

function onResult(parentElement, childElement, result, textValue) {
  $(parentElement).empty();

  if(Object.keys(result).length > 0) {
    creatOptions(parentElement, null, textValue =  textValue, '')
    creatOptions(parentElement, result)
  }
  else {
    if(childElement)
      $(childElement).empty();
  }
}
