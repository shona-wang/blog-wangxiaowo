//# sourceURL=index.js

/*
	加载静态资源
	creat by:wangxiaowo
	time:2016/11/03
*/
var BASE ={
	SRC_SITE : "./src/",
	// SRC_WRAP:"http://localhost:83/",
	SRC_WRAP:"//wrap.wangxiaowo.com/",
	SRC_IMG:"//img.wangxiaowo.com/img/"
};
(function(){
	var js = [
		"js/bootstrap.min.js",
		"js/TweenLite.min.js",
		"js/EasePack.min.js",
		"js/rAF.js",
		// "js/canvas1.js",
		"js/canvas2.js",
		"js/waterfall.js",
		"js/VerticalNav.js",
		"template/head/head.js",
		"template/foot/foot.js"
	];
	$(document).on("initRoute",function(){
		//创建路由
		$.getJSON(BASE.SRC_SITE+"json/route.json").done(function(config){
			window.routes = new RouteConfig(config);
			window.routes.build(null,function(){
                if(location.hash==""){
                    location.hash = "#index";
                }else{
                	 location.href="index.html#index";
                }
            });
		});
	});

	//加载js
	loadHtml().then(function(){
			//
		var i = 0;
		function loadNext(url,index){
			var script = document.createElement('script');
			script.type = "text/javascript";
			script.src = BASE.SRC_SITE +url;
			script.onload = function(){
				if(i < js.length-1){
					i++;
					loadNext(js[i],i);
				}else{
					$(document).trigger("initRoute");
					
				}
			};
			document.head.appendChild(script);
		}
		loadNext(js[i],i);
	});

	

	//加载框架html
	function loadHtml(){
		var i=0,
			def = $.Deferred(),
			temp = $("template");
		if(temp.length){
			temp.each(function(index, el) {
				var el= $(el),
					elSrc = BASE.SRC_SITE + el.attr("src");
				$.get(elSrc + ".html").done(function (html) {
				    el.replaceWith(html);
				}).fail(function(){
					console.log("加载失败！");
				}).always(function(){
					i++;
					if(i == temp.length){
						def.resolve();
					}
				});
			});
		}
		return def;
	}

})();
