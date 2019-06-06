$(document).ready(function() {
  for (let i = 0; i < 5;i ++) {
    $('.demo')[i].innerHTML = $('.myRange')[i].value;
    $('.myRange')[i].oninput = function() {
      $('.demo')[i].innerHTML = this.value;
    }
  }
  $('#submit_point').click(function() {
    $('#ratingModal').modal('hide');
  });
})
