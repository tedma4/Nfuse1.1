// $(document).on 'click' , '.cr' , (e)->
//     e.preventDefault()
//     $.ajax '/activities/read_all_notifications' ,
//         type: "post"
//         dataType: "json"
//         beforeSend: (xhr) ->
//           xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
//         cache: false

//$(document).on('click', '.cr', function(e) {
//  e.preventDefault();
//  return $.ajax('/activities/read_all_notifications', {
//    type: "post",
//    dataType: "json",
//    beforeSend: function(xhr) {
//      return xhr.setRequestHeader("X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content"));
//    },
//    cache: false
//  });
//});