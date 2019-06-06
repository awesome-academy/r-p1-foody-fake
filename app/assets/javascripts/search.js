const DOMAIN_API = 'http://localhost:3000/'

$(document).ready(function () {
  $('#search_restaurant_btn').on('click', search_restaurant)
  $('#near_restaurant_btn').on('click', search_near_restaurant)
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
