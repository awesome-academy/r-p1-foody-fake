DOMAIN_API = 'http://localhost:3000/'
$(document).ready(function() {
  $('#search_restaurant_btn').on('click', search_restaurant)
  $('#near_restaurant_btn').on('click', search_near_restaurant)
  for (let i = 0; i < $('.response_text_area').length; i++){
    $($('.response_text_area')[i]).keyup (function(event) {
      if (event.keyCode === 13) {
        event.preventDefault();
        $($('.response_text_area')[i]).parent().submit();
      }
    });
  }

  for (let i = 0; i < $('.edit-comment-btn').length; i++){
    $($('.edit-comment-btn')[i]).on('click', async function () {
      comment_id =  $($('.edit-comment-btn')[i]).attr('id');
      await $.ajax({
        url: DOMAIN_API + 'getcomment',
        data: {id: comment_id},
        success: function(result){
          $('#edit_comment_area').html(result.content);
          $('#edit_comment_area').parent().attr('action', '/comments/'+ result.id)
        }
      });
    })
  }

  for (let i = 0; i < $('.user-response').length; i++){
    $($('.user-response')[i]).mouseover(function () {
      $($($('.user-response')[i]).find('.delete-response-btn')[0]).css("visibility", "visible");
    })
    $($('.user-response')[i]).mouseout(function () {
      $($($('.user-response')[i]).find('.delete-response-btn')[0]).css("visibility", "hidden");
    })
  }
})

async function search_restaurant() {
  let province_name = $('#province_select option:selected').html()
  let district_name = $('#district_select option:selected').html()
  let ward_name = $('#ward_select option:selected').html()
  await $.ajax({
    url: DOMAIN_API + 'searchrestaurantbylocation',
    data: {
      province_name: province_name,
      district_name: district_name,
      ward_name: ward_name
    },
    success: function(result){
      console.log()
    }
  });
  await $(location).attr('href', DOMAIN_API + 'restaurants')
}

async function search_near_restaurant() {
  navigator.geolocation.getCurrentPosition(async function(location) {
    var latitude = await location.coords.latitude;
    var longitude = await location.coords.longitude;
    await $.ajax({
      url: DOMAIN_API + 'searchrestaurantnearme',
      data: {
        latitude: latitude,
        longitude: longitude
      },
      success: function() {
        window.location.href = DOMAIN_API + 'restaurants'
      }
    })
  })
}
