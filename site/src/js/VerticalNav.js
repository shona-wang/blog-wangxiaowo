//# sourceURL=VerticalNav.js 
;(function($,window,document){
	var pluginName = "sideNav",
		defaults = {
			fold: true,//默认二级以二级以上导航是否折叠
			contentId :"#content", 
			anchor:[]
		};
	var SideNav = function(self,options){
		this.self = self;
		this.options = $.extend({}, defaults, options);
		this.init();
	};
	SideNav.prototype = {
		constructor : SideNav,
		init : function(){
			var that = this,
				self = that.self;
			this.render();
			if(this.options.fold){
				$(self).find('.nav').hide();
				$(self).find('.navLi>a').on('click',function(e){
					$(this).parent('li').find("[class=nav]").toggle(400);
				});
			}
			this.scroll();
			$(self).find("a").on('click',function(e){
				$(self).find("li").removeClass('active');
				$(this).parent("li").addClass('active');
			});
			if($(self).find("li.active").attr("class") == "navLi active"){
				$(self).find("li.active .nav").show(400);
			}
		},
		render : function(){
			var anchor = this.options.anchor,
				contentId = this.options.contentId,
				that = this,
				resultHtml = "";
			anchor.forEach(function(e,i) {
				var cur = i == 0 ? "navLi active" : "navLi";
				var dom = '<li class="'+cur+'"><a href="javascript:void(0);" link="#'+e.id+'">'+e.name+'</a>',
					loopDom = that.loop(e.desc);
				dom = dom + loopDom + '</li>';
				resultHtml += dom;
				$(contentId).find("#"+e.id).addClass('items');//设置内容部分的class
			});
			$(that.self).append(resultHtml);
		},
		loop : function(ele){
			var domLi = "",
				domUl = "",
				resultLi = "",
				contentId = this.options.contentId,
				dom = '<ul class="nav">';
			for(var i=0;i<ele.length;i++){
				if(ele[i].desc){
					domLi = '<li><a href="javascript:void(0);" link="#'+ele[i].id+'">'+ele[i].name+'</a>'; 
					domUl = this.loop(ele[i].desc);
					domLi += domUl;
					$(contentId).find("#"+ele[i].desc.id).addClass('items');//设置内容部分的class
				}else{
					domLi = '<li><a href="javascript:void(0);" link="#'+ele[i].id+'">'+ele[i].name+'</a>';
					$(contentId).find("#"+ele[i].id).addClass('items');//设置内容部分的class 
				}
				resultLi = resultLi + domLi + '</li>' ;
			}
			return dom + resultLi + '</ul>';
		},
		scroll : function(){
			var contentId = this.options.contentId,
				self = this.self,
				items = $(contentId).find(".items");
			$(window).scroll(function(event) {
                var scrollBarTop = $(document).scrollTop();
                items.each(function(index, el) {
                	var itemsTop = $(this).offset().top;
                	if(scrollBarTop > itemsTop -120){
                        curId = "#"+$(this).attr("id");
                	}else{
                		return false;
                	}
                });
                var curLink =  $(self).find('.active');
                if(curId && curLink.find("a").eq(0).attr("link") != curId){
                	curLink.removeClass('active');
                	$(self).find('[link="'+curId+'"]').parent("li").addClass('active');
                }
                if($("li.active").parents('.navLi')){
                	$("li.active").parents('.navLi').addClass('active');
                	$("li.active").parents('.nav').show(400);
                }else{
                	$(".active.navLi").find(".nav").show(400);
                }
			});
		}
	};
	$.fn[pluginName] = function(options){
		this.each(function(index, el) {
			if(!$.data(this,"plugin-" + pluginName)){
				$.data(this,"plugin-" +pluginName,new SideNav(this,options));
			}
		});
	}
})(jQuery,window,document);