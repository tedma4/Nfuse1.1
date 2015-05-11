function resizeMasonry() {
 var box = $('#masonJar').width();
    //alert(box);
    //Keeps masonry sized correctly. Use this instead of css media querries
    // media querries won't work because profile page is at 75% width and explore/hub are 100%
    if(box < 400){
      $('.individual_post').css("width", "100%");
    }
    else if(box > 400 && 825 > box){
      $('.individual_post').css("width", "46.8%");
      al
    }
    else if(box > 825 && 1250 > box){
      $('.individual_post').css("width", "31%");
    }
    else if(box > 1250 && 1700 > box){
      $('.individual_post').css("width", "23.3%");
    }
    else if(box > 1700){
      $('.individual_post').css("width", "18.8%");
    }
}
;
