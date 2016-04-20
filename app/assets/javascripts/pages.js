  console.log('hit')
  $(document).on('scroll', function() {
    var url = $('.pagination .next_page').attr('href');
    if (url && $(document).scrollTop() > $(document).height() - $(document).height() - 2) {
      $('.pagination').text('Getting more things');
      return $.getScript(url);
    }
  });