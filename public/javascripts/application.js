
$(function(){
  
  // Start jquery.validate
  $('form.recurly_payment').validate({
    submitHandler: function (form) {
      $(form).addClass('submitting').find('*[type=submit]').attr('disabled', 'disabled').text('Please wait...');
      form.submit();
    }
  });


});