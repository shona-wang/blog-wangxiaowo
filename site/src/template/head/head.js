//# sourceURL=head.js 
(function () {
	var navbar = $("#nav_bar"),
		nav = ["ui","plugin","index","blog"],
		hashValue = location.hash,
		flg=false; 
	nav.forEach(function(e){
		if(hashValue.indexOf(e)>=0){
			flg=e;
		}
	});
    $("#header").on("click",["#nav_bar a","#logo a"],function (e) {
        var hash = $(e.target).attr("data-href");
        if (hash) {
            Route.go(hash);
        }
        find(hash);
        $(window).scrollTop(0);
    });
    function find(k){
    	var flgLi = navbar.find('[data-href = '+k+']').parent("li");
		flgLi.siblings('li').removeClass('active');
		flgLi.addClass('active');
    }
    find(flg);
})();