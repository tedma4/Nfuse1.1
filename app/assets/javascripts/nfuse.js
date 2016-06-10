  // NFUSE.JS
  // jQuery to collapse the navbar on scroll
  function scroll_function(){
    $(window).scroll(function(event) {

    if ($(".navbar").offset().top > 50) {
      $(".navbar-fixed-top").addClass("top-nav-collapse");
    } else {
      $(".navbar-fixed-top").removeClass("top-nav-collapse");
    }

    var y = $(this).scrollTop();
    if (y > 800) {
      $('#backtotop').addClass("isvis");
    } else {
      $('#backtotop').removeClass("isvis");
    }

    if ($('#profile-grid')) {
      var url = $('.nextBizPage').attr('href')
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() -25 ) {
        if ($('.nextBizPage').length ) {
          $('#paginate_only_once').html('<div id="paginate_only_once" style="text-align:center;">  <hr style="margin-left: 2rem; margin-right: 2rem; border-top: 1px solid #333;">  <i style="color: #00EEBC;" class="fa fa-cog fa-spin fa-3x fa-fw"></i><br>  <span>Loading...</span>  <br><br></div>');
          $.getScript(url)
        }
      }
    }

    if ($('article.tab-content #networks')) {
      var next_vue_url = $('.nextVuePages').attr('href')
      if (next_vue_url && $(window).scrollTop() > $(document).height() - $(window).height() -25 ) {
        if ($('.nextVuePages').length ) {
          $('#add_more_vue_pages').html('<div id="paginate_only_once" style="text-align:center;">  <hr style="margin-left: 2rem; margin-right: 2rem; border-top: 1px solid #333;">  <i style="color: #00EEBC;" class="fa fa-cog fa-spin fa-3x fa-fw"></i><br>  <span>Loading...</span>  <br><br></div>');
          $.getScript(next_vue_url)
        }
      }
    }
    });
  }

  function notifications_scrolling () {
    $('#notifications-list').on('scroll', function  () {
      if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
        if ($('#notifications-list .next').length ) {
          $('.next')[0].click();
        }
      }
    });
  }

  // JQUERY RESPONSIVE
  // Change width value on page load
  $(document).ready(function () {
    responsive_resize();
    scroll_function();
    notifications_scrolling();

    $('.timeline-user-box p').each(function () {
      if ($(this).text() === '') {
        $(this).remove()
      }
    });
  });

  // Change width value on user resize, after DOM
  $(window).resize(function () {
    responsive_resize();
  });

  function responsive_resize(){
    var current_width = $(window).width();
    //do something with the width value here!
    if (current_width <= 970){
      $('html').addClass("mobile").removeClass("desktop")
    }else{
      $('html').addClass("desktop").removeClass("mobile");
    }
  }

  // jQuery for background reload
  function shuffle(o){ //v1.0
    for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
    return o;
  };

  $(document).ready(function() {
    var desktopImages = ['Nfusebanner5dt.jpg', 'Nfusebanner6dt.jpg', 'Nfusebanner8dt.jpg', 'nfusebanner10dt.jpg','Nfusebanner1dt.jpg','Nfusebanner2DT.jpg','Nfusebanner3dt.jpg', 'after-jogging.jpg', 'bearded-diving.jpg', 'bride-groom.jpg', 'couple-driving.jpg', 'examining-leaves.jpg', 'friends-walking.jpg', 'girl-photographing.jpg', 'hiking-couple.jpg', 'jumping-jetty.jpg', 'midair-bike.jpg', 'mountain-biker.jpg', 'ocean-gliding.jpg', 'surfer-girl.jpg'];
    desktopImages = shuffle(desktopImages);

    $('html.desktop .random.bg').each(function(i){
      $(this).css({'background-image': 'url(/assets/bgs/desktop/' + desktopImages[i] + ')'});
    });

    var mobileImages = ['Nfusebanner5mbl.jpg', 'Nfusebanner6mbl.jpg', 'Nfusebanner8mbl.jpg', 'nfusebanner10mbl.jpg', 'Nfusebanner1mbl.jpg', 'Nfusebanner2mbl.jpg', 'Nfusebanner3mbl.jpg', 'after-jogging.jpg', 'bearded-diving.jpg', 'bride-groom.jpg', 'couple-driving.jpg', 'examining-leaves.jpg', 'friends-walking.jpg', 'girl-photographing.jpg', 'hiking-couple.jpg', 'jumping-jetty.jpg', 'midair-bike.jpg', 'mountain-biker.jpg', 'ocean-gliding.jpg', 'surfer-girl.jpg'];
    mobileImages = shuffle(mobileImages);

    $('html.mobile .random.bg').each(function(i){
      $(this).css({'background-image': 'url(/assets/bgs/mobile/' + mobileImages[i] + ')'});
    });
  });

  // Hashtag Shuffle
  var testArray = ['explore', 'fun', 'roadtrip', 'awesome', 'travel', 'memories', 'traveling', 'vacation', 'trip', 'photooftheday', 'instatravel', 'instago', 'nature', 'photo', 'friends', 'amazing'];
  shuffle(testArray);
  $(function() {
    for (var i=15;i<testArray.length;i++) {
      $("a.corner-tag").each(function(i) {
        $(this).append(testArray[i]);
      })
    }
  });

  // HEADER APPEAR ON SCROLL
  $(document).ready(function () {
    var didScroll;
    var lastScrollTop = 0;
    var delta = 5;
    var navbarHeight = $('#head-search').outerHeight();

    // on scroll, let the interval function know the user has scrolled
    $(window).scroll(function (event) {
      didScroll = true;
    });
    // run hasScrolled() and reset didScroll status
    setInterval(function () {
      if (didScroll) {
        hasScrolled();
        didScroll = false;
      }
    }, 150);
    function hasScrolled() {

      var st = $(this).scrollTop();

      // Make sure they scroll more than delta
      if (Math.abs(lastScrollTop - st) <= delta)
        return;

      // If they scrolled down and are past the navbar, add class .nav-up.
      // This is necessary so you never see what is "behind" the navbar.
      if (st > lastScrollTop && st > navbarHeight) {
        // Scroll Down
        $('#head-search').removeClass('down').addClass('up');
      } else {
        // Scroll Up
        if (st + $(window).height() < $(document).height()) {
          $('#head-search').removeClass('up').addClass('down');
        }
      }

      lastScrollTop = st;
    }
  });

  // Responsive Video
  $(function () {
    var $allVideos = $("iframe[src^='//player.vimeo.com'], iframe[src^='//www.youtube.com'], object, embed"),
      $fluidEl = $("figure");

    $allVideos.each(function () {
      $(this)
      // jQuery .data does not work on object/embed elements
        .attr('data-aspectRatio', this.height / this.width)
        .removeAttr('height')
        .removeAttr('width');

    });

    $(window).resize(function () {
      var newWidth = $fluidEl.width();
      $allVideos.each(function () {
        var $el = $(this);
        $el
          .width(newWidth)
          .height(newWidth * $el.attr('data-aspectRatio'));

      });
    }).resize();
  });

  // LIKE BUTTON
  jQuery(document).ready(function ($) {
    $(".likePost").click(function () {
      $(this).toggleClass("liked");
    });
  });
