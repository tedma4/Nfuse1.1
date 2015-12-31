// NFUSE.JS

// jQuery to collapse the navbar on scroll
    $(window).scroll(function() {
        if ($(".navbar").offset().top > 50) {
            $(".navbar-fixed-top").addClass("top-nav-collapse");
        } else {
            $(".navbar-fixed-top").removeClass("top-nav-collapse");
        }
    });

// jQuery scrolll to top
    $(document).scroll(function() {
        var y = $(this).scrollTop();
        if (y > 800) {
            $('#backtotop').addClass("isvis");
        } else {
            $('#backtotop').removeClass("isvis");
        }
    });

// jQuery for page scrolling feature - requires jQuery Easing plugin
    $(function() {
        $('a.page-scroll').bind('click', function(event) {
            var $anchor = $(this);
            $('html, body').stop().animate({
                scrollTop: $($anchor.attr('href')).offset().top
            }, 1500, 'easeInOutExpo');
            event.preventDefault();
        });
    });

// JQUERY RESPONSIVE

    // Change width value on page load
    $(document).ready(function(){
        responsive_resize();
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

// Slide Out 
    
    $(document).ready(function(){
        $(".signintoggler").click(function(){
            $("#signin").toggleClass("open");
            return false;
        });
        $(".signuptoggler").on('click', function(event){
            $("#foot-signup").toggleClass("open");
            return false;
        });
         $("#menutoggler").click(function(){
            $("#loggedin-nav").toggleClass("open");
            return false;
        });
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


    
