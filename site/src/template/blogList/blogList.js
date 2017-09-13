//# sourceURL=blogList.js
(function($,window,document){
	var page = {
		pageIndex : 0,
		pageSize:20,
		typeid:2,
		sortField:"ctime",
		sortOrder:"desc"
	};
	var CONFIG = {
		queryList : "./service/wrap.aspx?method=query",
		queryTag:"./service/wrap_target.aspx?method=query"
	},
	pageLength=0,
	targets=[];
	function queryTag(){
		var def=$.Deferred();
		$.getJSON(CONFIG.queryTag).done(function(data){
			var dom = template("targetList",{list:data});
			$("#list").html(dom);
			targets=adapter2(data);
			def.resolve();
		});
		return def;
	}

	function adapter2(text){
		var result = {};
		text.forEach(function(e){
			result[e.id]=e.name;
		});
		return result;
	}

	function adapter1(text){
		var data = text.data;
		data.forEach(function(e){
			var ids = e.targetid.split(",");
			e.tagsName = [];
			ids.forEach(function(id){
				e.tagsName.push({
					id:id,
					name:targets[id]
				});
			})
		});
		return text;
	}
	function queryList(){
		Nest.stopScroll();
		var def = $.Deferred();
		$.ajax({
			url:CONFIG.queryList,
			type:"post",
			data:page,
			cache:false,
			dataType:"json"
		}).done(function(text){
			pageLength = text.data.length;
			text = adapter1(text);
			var dom = template("blogData",text);
			$("#blogContent").prepend(dom);
			page.pageIndex ++;
			def.resolve(text);
		}).fail(function(err){
			console.log(err);
		});
		return def;
	}
	function build(total){
		var water = $("#blogContent").waterfall({
			itemClass: ".articleItem",
		    minColCount: 2,
		    spacingHeight: 10,
		    resizeable: true,
		    send:function(fn1,fn2){
		    	if(pageLength < total){
		    		queryList().done(fn1).fail(fn2);
		    	}else{
		    		$(".tips").show();
		    	}
		    }
		});
	}
	(function pageLoad(){
		$("#blogContent").on('click',function(e){
			var target = e.target,
				name = target.tagsName;
			if(name == "A"){
				Route.go($(e.target).attr('url'));
			}
		});
		queryTag().then(queryList).then(function(data){
			var img = $("#blogContent .pic img"),
				l = img.length,
				i = 0;
			function imgLoad(){
				i++;
				if(i == l){
					build(data.total);
				}
			}
			img.each(function(index,e){
				e = $(e);
				e.on("load",function(){
					imgLoad();
				}).on("error",function(){
					e.attr("src",BASE.SRC_SITE + "img/default.jpg");
					imgLoad();
				});
				e.attr("src",e.attr("data-img"));
			});
		});
	})();


})(jQuery,window,document);