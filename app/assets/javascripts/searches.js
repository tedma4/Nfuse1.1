(function ($) {
    // when document is ready for manipulation
    $(document).ready(function () {
 
        // our search box with id of search
        $('#search').each(function () {
            $(this).attr('title', $(this).val())
                .focus(function () {
                    if ($(this).val() == $(this).attr('title')) {
                        $(this).val('');
                    }
                }).blur(function () {
                    if ($(this).val() == '' || $(this).val() == ' ') {
                        $(this).val($(this).attr('title'));
                    }
                });
        });
 
        $('input#search').result(function (event, data, formatted) {
            $('#result').html(!data ? "No match!" : "Selected: " + formatted);
        }).blur(function () {});
 
        $(function () {
            // returns the image in the autocomplete results and also a link pointing to the results
            // and also the results title. Note we must pass (permalink, image, and title) in our json results	
            function format(mail) {
                return "<a href='" + mail.permalink + "'><img src='" + mail.image + "' /><span class='title'>" + mail.title + "</span></a>";
            }
 
            // returns the url of the result		
            function link(mail) {
                return mail.permalink
            }
 
            // returns the title of the results
            function title(mail) {
                return mail.title
            }
 
            // Invoke our autocomplete plugin and give it a url where it should fetch for results. In our case is /search
            // we defined this custom action in our roots.rb file. Change this to suite yours		
            $("#search").autocomplete('/search', {
                width: $("#search").outerWidth() - 2, //match width of input box (search box)		
                max: 5, // maximum of five results	
                scroll: false, // disable scroll in results
                dataType: "json", // expect json data
                matchContains: "word",
                parse: function (data) {
                    return $.map(data, function (row) {
                        return {
                            data: row,
                            value: row.title,
                            result: $("#search").val()
                        }
                    });
                },
                formatItem: function (item) {
                    return format(item);
                }
            }).result(function (e, item) {
                // add the clicked result title in the search box
                $("#search").val(title(item));
                // redirect to the result's url
                location.href = link(item); 
            });
        });
 
    });
})(jQuery);