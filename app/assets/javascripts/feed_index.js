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
      var scrollbarPosition = $(this).scrollTop();
      var documentHeight = $(this).height();

      if (documentHeight - scrollbarPosition < 7500 && reloadOk === true) {
        $(".loading_message").show();
        var nextPageUrl = $(".load_posts_link a").attr("href");
        reloadOk = false;
        $.get(nextPageUrl).success(function (response) {
          reloadOk = true;
          $(".load_posts_link").replaceWith(response);
          $(".loading_message").hide();
        });
      }
    });

    $(document).on('click', '.create_post_link', function (event) {
      event.preventDefault();
      var div = JST['templates/create_post'](FeedIndex.providers);
      $('#feed_content').before(div);
    });

    $(document).on('submit', '#create_post_form', function (event) {
      event.preventDefault();
      var post = $(this)[0][2].value;
      var twitter;
      var facebook;
      if ($(this).children('#provider_twitter').length > 0) {
        twitter = $(this).children('#provider_twitter')[0].checked;
      }

      if ($(this).children('#provider_facebook').length > 0) {
        facebook = $(this).children('#provider_facebook')[0].checked;
      }
      var url = $(this).data('behavior');
      $.post(url + "?" + "post=" + post + "&" + "twitter=" + twitter + "&" + "facebook=" + facebook).success(function (response) {
        $("#create_posts_container").remove();
        if (response.tweet !== null) {
          var twitter_div = JST['templates/twitter_post'](response.tweet);
          $("#feed_container").prepend(twitter_div);
        }
        if (response.facebook_post !== null) {
          var facebook_div = JST['templates/facebook_post'](response.facebook_post);
          $("#feed_container").prepend(facebook_div);
        }
      });
    });

    $(document).on('click', '[data-twitter-favorite-count]', function (event) {
      event.preventDefault();
      var target = $(event.target).closest('li');
      var endpoint = target.find('a').attr('href');
      $.post(endpoint).success(function (response) {
        target.find('.js-twitter-favorite-count').html(response.favorite_count);
      });
    });

    $(document).on('click', '[data-twitter-retweet-count]', function (event) {
      event.preventDefault();
      var target = $(event.target).closest('li');
      var endpoint = target.find('a').attr('href');
      $.post(endpoint).success(function (response) {
        var tweet = response.tweet;
        target.find('.js-twitter-retweet-count').html(tweet.retweet_count);
      });
    });

    $(document).on('click', '[data-instagram-like-count]', function (event) {
      event.preventDefault();
      var target = $(event.target).closest('li');
      var endpoint = target.find('a').attr('href');
      $.post(endpoint).success(function (response) {
        target.find('.js-instagram-like-count').html(response.likes.count);
      });
    });

    $(document).on('click', '[data-facebook-like-count]', function (event) {
      event.preventDefault();
      var target = $(event.target).closest('li');
      var endpoint = target.find('a').attr('href');
      $.post(endpoint).success(function (response) {
        target.find('.js-facebook-like-count').html(response.likes.data.length);
      });
    });
  }

};
