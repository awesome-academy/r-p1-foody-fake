$(document).ready(function() {
  for (let i = 0; i < $('.alert').length; i++){
    setTimeout($($('.alert')[i]), 3000);
  }
})
