(function($,window){
	$("#sideNavBox").sideNav({
		fold: true,//默认二级以二级以上导航是否折叠
		contentId :"#uiContent",
		anchor:[{
		        "id": "color",
		        "name":"配色",
		        "desc": [{
		        		"id":"mainColor",
		        		"name":"主颜色"
		        	},{
		        		"id":"blackWhiteColor",
		        		"name":"黑白色板"
		        	},{
		        		"id":"mixColor",
		        		"name":"混合色板"
		        	},{
		        		"id":"statusColor",
		        		"name":"状态色板"
		        	},{
		        		"id":"lineColor",
		        		"name":"线条背景颜色"
		        	},{
		        		"id":"fontColor",
		        		"name":"字体颜色"
		        	},{
		        		"id":"buttonColor",
		        		"name":"按钮HOVER"
		        	}]
		    },
		    {
		        "id": "formList",
		        "name" : "表单",
		        "desc": [{
		        		"id":"form",
		        		"name":"表单"
		        	},{
		        		"id":"button",
		        		"name":"按钮"
		        	}]
		    }]
	});
	$("#sideNavBox a").on("click",function(e){
		var link = $(this).attr("link");
		var top = $("#uiContent").find(link).offset().top;
		$("html,body").animate({scrollTop:top},500);
	});
})(jQuery,window);
