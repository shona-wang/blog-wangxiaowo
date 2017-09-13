//# sourceURL=foot.js 
(function () {
	var navbar = $("#navLink"),
		nav = ["ui","plugin","index","blog"],
		hashValue = location.hash,
		flg=false; 
	nav.forEach(function(e){
		if(hashValue.indexOf(e)>=0){
			flg=e;
		}
	});
    $("#foot").on("click","#navLink a",function (e) {
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