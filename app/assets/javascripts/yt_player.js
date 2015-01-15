jQuery(function() {
  var bindAndFireResize, makeVideoPlayer, setPlayerProportions, _run;
  makeVideoPlayer = function(wrapper, video) {
    if (!window.ytPlayerLoaded) {
      wrapper.append('<div id="ytPlayer"><p>Loading player...</p></div>');
      window.ytplayer = new YT.Player('ytPlayer', {
        width: '100%',
        height: wrapper.width() / 1.777777777,
        videoId: video,
        playerVars: {
          wmode: 'opaque',
          autoplay: 0,
          modestbranding: 1
        },
        events: {
          'onReady': function() {
            return window.ytPlayerLoaded = true;
          },
          'onError': function(errorCode) {
            return alert("We are sorry, but the following error occured: " + errorCode);
          }
        }
      });
    } else {
      window.ytplayer.loadVideoById(shout);
      window.ytplayer.pauseVideo();
    }
  };
  $('.yt_preview').click(function() {
    var wrapper;
    wrapper = $(this).closest('.yt-video').find('.yt-player-wrapper');
    return makeVideoPlayer(wrapper, $(this).data('uid'));
  });
  window.ytPlayerLoaded = false;
  _run = function() {
    $('.yt_preview').first().click();
  };
  setPlayerProportions = function() {
    var player;
    player = $('#ytPlayer');
    if (player.size() > 0) {
      player.height(player.width() / 1.777777777);
    }
  };
  bindAndFireResize = function() {
    $(window).bind('resize', setPlayerProportions);
    return setPlayerProportions();
  };
  setTimeout(bindAndFireResize, 500);
  google.setOnLoadCallback(_run);
});