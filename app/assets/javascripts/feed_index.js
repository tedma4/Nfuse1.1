FeedIndex = {

  initialize: function () {
    var reloadOk = false;
    var user_id  = $('#masonJar').data('user-id');

    $.get("/feed_content?id=" + user_id ).success(function (response) {
      var loadingMessage = $(".loading_message");
      loadingMessage.before(response);
      loadingMessage.hide();
    }).success(function () {
      reloadOk = true
    });

    $(document).scroll(function () {
      //var scrollbarPosition = $(this).scrollTop();
      //var documentHeight = $(this).height();

        //Delete this line if it doesn't work
        if ($(this).height() - $(this).scrollTop() < 2500 && reloadOk === true) {

//      if (documentHeight - scrollbarPosition < 7500 && reloadOk === true) {
        $(".loading_message").show();
        var nextPageUrl = $(".load_posts_link a").attr("href");
        reloadOk = false;
        $.get(nextPageUrl).success(function (response) {
          reloadOk = true;
          $(".load_posts_link").replaceWith(response);
          $(".loading_message").hide();
          msnry.destroy();
          initMasonry();
          resizeMasonry();
        });
      }
    });
    
  }

};
