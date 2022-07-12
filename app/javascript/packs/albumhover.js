$(document).ready(function() {

	$('.card').delay(2400).queue(function(next) {
		$(this).removeClass('hover');
		$('a.hover').removeClass('hover');
		next();
	});
});
