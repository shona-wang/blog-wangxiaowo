/* 项目通用函数 
	creat by : wangxiaowo
	time : 2016/11/03
*/
(function($,window,undefined){
	var Nest = {
		getResource: function(url){
			$(".loading").show();
			var def = $.Deferred(),
				k = 0; 
			try{
				if(url instanceof Array){
					url.forEach(function(e){//都去请求，如果都发了请求则设置def的状态为resolve()
						$.get(e).fail(function(){
							console.log("请求失败");
						}).always(function(){
							k++;
							if(k == url.length){
								def.resolve();
							}
						});
					});
				}else{
					$.get(url).done(function(data){
						$(".loading").hide();
						def.resolve(data);
					})
				}
			}catch(err){
				$(".loading").hide();
				def.reject(err);
			}
			return def;
		},	
		loading : function(k,v){
			if(v.indexOf("wrap") >=0){
				v = location.hash.replace("#","").replace(v+"/","");
				v=v.substr(0,v.length-2);
				var comment = parseInt(location.hash.substr(-1));
				Nest.getResource(BASE.SRC_WRAP+v).then(function(data){
				    $("#content").html(data);
					if(comment){
						var url = BASE.SRC_SITE+'template/comment/comment';
						Nest.getResource(url+'html').then(function(text){
							$("#content").append(text);
							$("head").append('<script type="text/javascript" src="' + url+'.js"></script>');
						})
					}
				});
			}else{
				Nest.getResource(BASE.SRC_SITE+"template/"+v+"/"+v+".html").then(function(data){
				    $("#content").html(data);
				    $("head").append('<script type="text/javascript" src="' + BASE.SRC_SITE +"template/"+ v + "/" + v + '.js"></script>');
				});
			}
		},
		stopScroll:function(){
			$(document).css({
				"overflow":"hidden",
				"height":"100%"
			});
			$(document).on("touchMove",function(e){
				e.preventDefault();
			});
		}
	};
	var RouteConfig = function(config){
		if(!this instanceof RouteConfig){
			return new RouteConfig(config);
		}
		this.add(config);
	};
	RouteConfig.prototype = {
		/*
			添加或修改路由配置
			示例：
			RouteConfig.add("login","template/login.html").then(function(tpl){
				//tpl为请求返回的模板数据
			})
		*/
		add : function(k,v){
			if(typeof k == "string"){
				this[k] = this.setup(k,v);
			}else{
				for(var i in k){
					this[i] = this.setup(i,k[i]);
				}
			}
			//return this;
		},
		/*
			删除某个路由配置项
			return {{RouteConfig}}
			示例：
			RouteConfig.remove("login");
		*/
		remove : function(k){
			this[k] && delete this[k];
			return this;
		},
		/*
			路由设置
		*/
		setup : function(k,v){
			// Nest.loading(k,v);
			return function(){
				Nest.loading(k,v);
			}
		},
		build: function (params,defaultAction) {
		    var  route = {};
            if(params){
	    		 for(var k in this){
	                route[params+"/"+k]=this[k];
	            }
	    	}
	    	else{
	            	route = this;
	        }
	    	Route.init(route,defaultAction);
		},
		rebuild:function(params){
			if(params){
				var route = {};
	            for(var k in this){
	                route[params+"/"+k]=this[k];
	            }
	            Route.init(route,defaultAction,true);
	        }
		}
	};
	/**
     * 扩展template对日期进行格式化，
     * @param date 要格式化的日期
     * @param format 进行格式化的模式字符串
     *     支持的模式字母有：
     *     y:年,
     *     M:年中的月份(1-12),
     *     d:月份中的天(1-31),
     *     h:小时(0-23),
     *     m:分(0-59),
     *     s:秒(0-59),
     *     S:毫秒(0-999),
     *     q:季度(1-4)
     * @return String
     * @author yanis.wang
     * @see	http://yaniswang.com/frontend/2013/02/16/dateformat-performance/
     */
    template.helper('dateFormat', function (date, format) {
        date = new Date(date);
        var map = {
            "M": date.getMonth() + 1, //月份
            "d": date.getDate(), //日
            "h": date.getHours(), //小时
            "m": date.getMinutes(), //分
            "s": date.getSeconds(), //秒
            "q": Math.floor((date.getMonth() + 3) / 3), //季度
            "S": date.getMilliseconds() //毫秒
        };
        format = format.replace(/([yMdhmsqS])+/g, function(all, t){
            var v = map[t];
            if(v !== undefined){
                if(all.length > 1){
                    v = '0' + v;
                    v = v.substr(v.length-2);
                }
                return v;
            }
            else if(t === 'y'){
                return (date.getFullYear() + '').substr(4 - all.length);
            }
            return all;
        });
        return format;
    });
	$.extend(window,{
		Nest : Nest,
		RouteConfig : RouteConfig
	});

})(jQuery,window);