$(document).on "page:change"(function(){
	$('.menuDropdown').hide();
	$('.dropdown-toggle').click(function () {
		$('.menuDropdown').toggle(300);
	});
});