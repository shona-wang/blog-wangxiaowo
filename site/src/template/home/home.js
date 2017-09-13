//# sourceURL=home.js
(function($,document){
	var docHeight = $(window).height();
	$(".home_part1").height(docHeight);
	$(".home_part2").height(docHeight);
	initHeader();
	addListeners();
})(jQuery,document);