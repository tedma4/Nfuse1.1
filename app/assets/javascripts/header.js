$(document).on "page:load"(function(){
	$('.menuDropdown').hide();
	$('.dropdown-toggle').click(function () {
		$('.menuDropdown').toggle(300);
	});
});