/*!
 * Start Bootstrap - Grayscale Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

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

// jQuery for background reload
    function shuffle(o){ //v1.0
        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    };
    $(document).ready(function() {
        var images = ['andreialex.jpeg', 'antonioguillem.jpeg', 'chloeboulos.jpeg', 'corepics.jpeg', 'dreamypixel.jpeg', 'dreamypixel2.jpeg', 'erikreis.jpeg', 'janne_amunet.jpeg', 'janne_amunet2.jpeg', 'janne_amunet3.jpeg', 'leezee.jpeg', 'monkeybusiness.jpeg', 'nth169.jpeg', 'paulschlemmer.jpeg', 'paulschlemmer2.jpeg', 'vlad_star.jpeg'];
        images = shuffle(images);

        $('.random.bg').each(function(i){
            $(this).css({'background-image': 'url(img/bgs/' + images[i] + ')'});  
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
            new $('<img src="img/users/' + users[Math.floor(Math.random() * users.length)] + '">').appendTo(this);
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

// MASONARY

    
