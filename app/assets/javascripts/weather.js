$(document).ready(function(){
  $('submit').click(function() {
    $.ajax({
      url: '/get_weather',
      type: 'post',
      //data: $('#p_code')
      success: function(response) {
        console.log(response)
      }
    })
  })
})
