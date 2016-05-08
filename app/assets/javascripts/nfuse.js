// NFUSE.JS

// jQuery to collapse the navbar on scroll
  function scroll_function(){
    $(window).scroll(function() {
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

        // var url = $('.next a').attr('href'); //attr('href') = /pages/#
        // if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 1) {
        //   $('.pagination').text('Getting more things');
        //   return $.getScript(url);
        // }



    });

  }
 
  function notifications_scrolling () {
    $('#notifications-list').on('scroll', function  () {
        if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
            console.log('works');
            $('.next')[0].click();
        }
    });
  }

// JQUERY RESPONSIVE

    // Change width value on page load
    $(document).ready(function(){
        responsive_resize();
        scroll_function();
        notifications_scrolling();
        
    $('.timeline-user-box p').each(function(){
      if($(this).text() === ''){$(this).remove()}
    });
    });

    // Change width value on user resize, after DOM
    $(window).resize(function(){
         responsive_resize();
    });

    function responsive_resize(){
        var current_width = $(window).width();
        //do something with the width value here!
        if (current_width < 970)
            $('html').addClass("mobile").removeClass("desktop")

        else if (current_width > 971)
            $('html').addClass("desktop").removeClass("mobile");
    }

// jQuery for background reload
    function shuffle(o){ //v1.0
        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    };
    $(document).ready(function() {
        var images = ['after-jogging.jpg', 'bearded-diving.jpg', 'bride-groom.jpg', 'couple-driving.jpg', 'examining-leaves.jpg', 'friends-walking.jpg', 'girl-photographing.jpg', 'hiking-couple.jpg', 'jumping-jetty.jpg', 'midair-bike.jpg', 'mountain-biker.jpg', 'ocean-gliding.jpg', 'surfer-girl.jpg'];
        images = shuffle(images);

        $('html.desktop .random.bg').each(function(i){
            $(this).css({'background-image': 'url(/assets/bgs/desktop/' + images[i] + ')'});
        });
    });

// jQuery for mobile background reload
    function shuffle(o){ //v1.0
        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    };
    $(document).ready(function() {
        var images = ['after-jogging.jpg', 'bearded-diving.jpg', 'bride-groom.jpg', 'couple-driving.jpg', 'examining-leaves.jpg', 'friends-walking.jpg', 'girl-photographing.jpg', 'hiking-couple.jpg', 'jumping-jetty.jpg', 'midair-bike.jpg', 'mountain-biker.jpg', 'ocean-gliding.jpg', 'surfer-girl.jpg'];
        images = shuffle(images);

        $('html.mobile .random.bg').each(function(i){
            $(this).css({'background-image': 'url(/assets/bgs/mobile/' + images[i] + ')'});
        });
    });

// Hashtag Shuffle
    function Shuffle(o) {
        for(var j, x, i = o.length; i; j = parseInt(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    };

    var testArray = ['explore', 'fun', 'roadtrip', 'awesome', 'travel', 'memories', 'traveling', 'vacation', 'trip', 'photooftheday', 'instatravel', 'instago', 'nature', 'photo', 'friends', 'amazing'];

    Shuffle(testArray);

    $(function() {
       for (var i=15;i<testArray.length;i++) {
          $("a.corner-tag").each(function(i) {
            $(this).append(testArray[i]);
        })
       }
    });

// User Feed

    /*$(document).ready(function() {
        var users = ['AmericanIdol.jpg', 'BrunoMars.jpg', 'CW_TheFlash.jpg', 'ddlovato.jpg', 'CW_TheFlash.jpg', 'Enews.jpg', 'HuffPostFood.jpg', 'Jason_Aldean.jpg', 'JayZClassicBars.jpg', 'jimmyfallon.jpg', 'LouisVuitton.jpg', 'MapleLeafs.jpg', 'NicoandVinz.jpg', 'RedSox.jpg', 'RollingStones.jpg', 'ScandalABC.jpg', 'taylorswift.jpg', 'troyesivan.jpg'];
        users = shuffle(users);

        $('.user-block').each(function() {
            new $('<img src="/assets/users/' + users[Math.floor(Math.random() * users.length)] + '">').appendTo(this);
        })
    });*/

// OFF CANVAS

    $(document).ready(function(){

        // $(".signintoggler").click(function(){
        //     $("#signin").toggleClass("open");
        //     return false;
        // });
        // $(".signuptoggler").on('click', function(event){
        //     $("#foot-signup").toggleClass("open");
        //     return false;
        // });

        // $("#menutoggler").click(function(){
        //     $('#slide-nav').offcanvas({
        //         autohide: true,
        //         toggle: true,
        //         placement: 'right',
        //         recalc: false,
        //         disableScrolling: false
        //     }).offcanvas('toggle');

        //     $('.slide-out').offcanvas('hide');
        //     return false;
        // });
    });
    $(document).ready(function(){
        // $("#notifications").click(function(){
        //     $('#notifications-list').offcanvas({
        //         autohide: true,
        //         toggle: true,
        //         placement: 'right',
        //         recalc: false,
        //         disableScrolling: false
        //     }).offcanvas('toggle');

        //     $('.slide-out').offcanvas('hide');
        //     return false;
        // });

    });


    // HEADER APPEAR ON SCROLL
    $(document).ready(function(){
        var didScroll;
        var lastScrollTop = 0;
        var delta = 5;
        var navbarHeight = $('#head-search').outerHeight();

        // on scroll, let the interval function know the user has scrolled
        $(window).scroll(function(event){
            didScroll = true;
        });
        // run hasScrolled() and reset didScroll status
        setInterval(function() {
          if (didScroll) {
            hasScrolled();
            didScroll = false;
          }
        }, 150);
        function hasScrolled() {

            var st = $(this).scrollTop();

            // Make sure they scroll more than delta
            if(Math.abs(lastScrollTop - st) <= delta)
                return;

            // If they scrolled down and are past the navbar, add class .nav-up.
            // This is necessary so you never see what is "behind" the navbar.
            if (st > lastScrollTop && st > navbarHeight){
                // Scroll Down
                $('#head-search').removeClass('down').addClass('up');
            } else {
                // Scroll Up
                if(st + $(window).height() < $(document).height()) {
                    $('#head-search').removeClass('up').addClass('down');
                }
            }

            lastScrollTop = st;
        }
    });

// Responsive Video

    $(function() {

        var $allVideos = $("iframe[src^='//player.vimeo.com'], iframe[src^='//www.youtube.com'], object, embed"),
        $fluidEl = $("figure");

        $allVideos.each(function() {

          $(this)
            // jQuery .data does not work on object/embed elements
            .attr('data-aspectRatio', this.height / this.width)
            .removeAttr('height')
            .removeAttr('width');

        });

        $(window).resize(function() {

          var newWidth = $fluidEl.width();
          $allVideos.each(function() {

            var $el = $(this);
            $el
                .width(newWidth)
                .height(newWidth * $el.attr('data-aspectRatio'));

          });

        }).resize();

    });

    $("iframe").wrap("<div class='embed-container'/>");

// LIKE BUTTON

    jQuery(document).ready(function($) {
        $(".likePost").click(function() {
            $(this).toggleClass("liked");
        });
    });

    /*$(document).ready(function(){
        $('#exclusivemodal').on('shown.bs.modal', function () {
            $('.notification.exclusive').click();
        });
    });*/

// FILE PREVIEW
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#profilepic').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#inputprof").change(function () {
        readURL(this);
    });

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#profilebann').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#inputbann").change(function () {
        readURL(this);
    });






// jQuery scrolll to top
//     $(document).scroll(function() {
//         var y = $(this).scrollTop();
//         if (y > 800) {
//             $('#backtotop').addClass("isvis");
//         } else {
//             $('#backtotop').removeClass("isvis");
//         }

//       if ($('.pagination').length) {
//         $(window).scroll(function() {
//           var url;
//           url = $('.pagination .next_page').attr('href');
//           if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
//             $('.pagination').text('Getting more things');
//             return $.getScript(url);
//           }
//         });
//       }
//       return $(window).scroll();

//     });

// jQuery for page scrolling feature - requires jQuery Easing plugin
    // $(function() {
    //     $('a.page-scroll').bind('click', function(event) {
    //         var $anchor = $(this);
    //         $('html, body').stop().animate({
    //             scrollTop: $($anchor.attr('href')).offset()
    //         }, 1500, 'easeInOutExpo');
    //         event.preventDefault();
    //     });
    // });