$(document).ready(function(){
	$('.menuDropdown').hide();
	alert("header.js");
	$('.dropdown-toggle').click(function () {
		$('.menuDropdown').toggle(300);
	});
});