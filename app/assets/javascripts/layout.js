Layout = {

  initialize: function () {
    var menuButtonContainer = $('#menu_button_container li')

    $('#menu_button').click(function () {
      $('.mobile_menu').slideToggle();
    });

    $(window).resize(function () {
      if ($('.mobile_menu').css('border') === '0px none rgb(255, 255, 255)') {
        menuButtonContainer.css('display', 'inline-block')
        $('.mobile_menu').show();
        $('#menu_button').hide();
      }
      else {
        menuButtonContainer.css('display', 'block')
        $('.mobile_menu').hide();
        $('#menu_button').show();
      }
    });
  }
};
