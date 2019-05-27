const DOMAIN_API = 'http://localhost:3000/'
$(document).ready(function() {
  $('#order_now_btn').on('click', update_status_order)
})

async function update_status_order() {
  await $.ajax({
    url: DOMAIN_API + 'updatestatus',
    success: function(result){
      console.log()
    }
  });
  await $(location).attr('href', DOMAIN_API)
}
