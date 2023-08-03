
$(document).ready(function() {

  $('#enrollmentForm').on('submit', function(e) {
    e.preventDefault();
    var formData = $(this).serialize();


    $.ajax({
      type: 'POST',
      url: '/payment/enroll_in_course',
      data: formData,
      success: function(response) {

        $('#message').text(response.message).addClass('success');
      },
      error: function(xhr) {
            $('#message').text(xhr.responseJSON.error).addClass('error');
      }
    });
  });
});
