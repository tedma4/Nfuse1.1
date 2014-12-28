jQuery ->
  makeVideoPlayer = (wrapper, video) ->
    if !window.ytPlayerLoaded
      wrapper.append('<div id="ytPlayer"><p>Loading player...</p></div>')

      window.ytplayer = new YT.Player('ytPlayer', {
        width: '100%'
        height: wrapper.width() / 1.777777777
        videoId: video
        playerVars: {
          wmode: 'opaque'
          autoplay: 0
          modestbranding: 1
        }
        events: {
          'onReady': -> window.ytPlayerLoaded = true
          'onError': (errorCode) -> alert("We are sorry, but the following error occured: " + errorCode)
        }
      })
    else
      window.ytplayer.loadVideoById(shout)
      window.ytplayer.pauseVideo()
    return

  $('.yt_preview').click ->
    wrapper = $(this).closest('.yt-video').find('.yt-player-wrapper')
    makeVideoPlayer(wrapper, $(this).data('uid'))

  window.ytPlayerLoaded = false

  _run = ->
    $('.yt_preview').first().click()
    return

  setPlayerProportions = ->
    player = $('#ytPlayer')
    player.height(player.width() / 1.777777777) if player.size() > 0
    return
  bindAndFireResize = ->
    $(window).bind('resize', setPlayerProportions)
    setPlayerProportions()
  setTimeout(bindAndFireResize, 500)

  google.setOnLoadCallback _run

  return