/**
* @fileOverview 核心的框架类
* @author <a href="http://www.wgfly.com">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name FW
* @description  breeze的基本控制对象，这个对象通常取名为FW
*/
define(function(require, exports, module) {
	var _win = window;
	var _doc = _win.document;
	var _obj = module.exports = {};
	var _gadget = {};
	var _app = {};
	var _container = {};
	var _allPost = _createPost();
	var _doserverUrl = null;

	/*
	 * 2013-04-29新加入的use机制
	 * 这里面放置的是默认的API信息
	 */
	var _useAPI = {
		lang:require("./tools/Lang")//这是默认的
	};

	//加载jquery.blockUI 源码并执行
	(require("./jquery.blockUI"))();

	//post对象
	function _createPost(){
		var _postData = [];
		return {
			addPost:function(__oneData){
				_postData.push(__oneData);
			},
			clear:function(){
				_postData=[];
			},
			doPost:function(__finishedCallback,__this){
				if (_postData == null || _postData.length == 0){
					return;
				}
				var pObj = {};
				for (var i =0;i<_postData.length;i++){
					//保留回调函数以及序号
					pObj[i] = _postData[i].callBack;
					pObj[i].thisObj = _postData[i].callbackThisObj;
					delete _postData[i].callbackThisObj;
					delete _postData[i].callBack;
				}
				var dataStr = _useAPI.lang.toJSONString(_postData);
				//2013-09-14修改
				//从url中获取参数，是否存在threadSignal,如果存在了，则将改标识发到服务端，并启动服务端的日志跟踪系统
				var myurl = window.location.toString();
				var threadSignal = null;
				var execResult = (new RegExp("threadSignal=([\\w%\\.]+)")).exec(myurl);
				if (execResult){
					threadSignal = execResult[1];
				}
				var postUrl = _doserverUrl;
				if (threadSignal){
					postUrl = _doserverUrl + "?threadSignal="+threadSignal;
				}

				$.post(postUrl,{data:dataStr},
				function(__returndata){
					for (var key in __returndata){
						if (!__returndata.hasOwnProperty(key)){
							continue;
						}
						pObj[key] && pObj[key].apply(pObj[key].thisObj,[__returndata[key].code,__returndata[key].data]);
					}
//					for(var i=0;i<__returndata.length;i++){
//						var sName = __returndata[i].name;
//						pObj[sName] && pObj[sName].callBack(__returndata[i].code,__returndata[i].data);
//					}
					//最后所有都结束了，统一给一个通知
					__finishedCallback && __finishedCallback.apply(__this||this,[]);
				},
				"json");
			}
		};
	}
	//为每个app创建一个工具类
	function _createFWTools(__app){
		var _$app = __app;
		//这个函数专门用于API批量提交post请求时用的临时变量
		var tmpPostObj  = null;
		/**
		* @namespace
		* @author Alec
		* @name API
		* @description  在FW中为每个gadget创建的内部公用函数，调用时使用this.API.xxx即可
		*/
		return {
			/**
			*@function
			*@name show
			*@memberOf API
			*@description 显示视图，即在本APP中显示一个指定的视图，视图即在html中，声明于app下的任何顶级带id的标签,建议这些标签id为view_前缀
			*@param {String} viewId 要显示的视图名称，某个顶级的标签的id
			*@param {Object} data 视图中使用的解析数据，在视图中将使用data引用这个对象
			*@param {String} target 视图显示的目标selector（jquery的selector），视图默认（即不填写该参数）将会把视图显示到app中，如果不是要覆盖当前视图，而是把这个视图显示到当前视图下都某个标签下，则填写该标签的selector
			*@example
			*this.API.show("view1",data);
			*/
			show:function(__viewId,__data,__target,__transition){
				//先将数据记录到本地存储中
				if (__data){
					_useAPI.lang.save("__viewId:"+__viewId,__data);
				}

				var target = _$app.dom;
				if (__target ){
					target = _$app.dom.find(__target);
					if (!target || target.length == 0){
						target = _$app.dom.find("#"+__target);
					}
					if (!target || target.length == 0){
						target = $("#"+__target+"_"+_$app.id);
					}
					if (!target || target.length == 0){
						target = _$app.dom;
					}
				}
				var src = _$app.view[__viewId];
				if (src == null){
					if(__transition){
						target.hide().html(__viewId).fadeIn(300);
					}else{
						target.html(__viewId);
					}

					return;
				}
				//针对火狐把href中的${进行转移到处理
				src = src.replace(/(href=["'])([^"']+)(["'])/ig,
						function(all,a,b,c){
							return a+b.replace(/\$%7B/ig,function(a){return "${"}).replace(/%7D/ig,"}")+c;
						});
				var htmlStr = _useAPI.lang.parserTemplate(src,__data,_useAPI);
				//进行事件替换
				htmlStr = htmlStr.replace(/["]?\s*FireEvent\.(\w+)\(([^\)]*)\)\s*["]?/ig,function(a,b,c){
					var result = "\"var args=[" + c + "];";
					result += ("var app = $('#" + _$app.id + "')[0].app;");
					result += ("app.FireEvent." + b + ".apply(app,args)" + "\"");
					return result;
				});
				if(__transition){
					target.hide().html(htmlStr).fadeIn(300);
					return;
				}
				target.html(htmlStr);
				target.show();
			},
			/**
			*@function
			*@name showBack
			*@memberOf API
			*@description 回显视图，即在本APP中显示一个指定的视图，使用的是上次的事图显示的数据
			*@param {String} viewId 要显示的视图名称，某个顶级的标签的id
			*@param {String} target 视图显示的目标selector（jquery的selector），视图默认（即不填写该参数）将会把视图显示到app中，如果不是要覆盖当前视图，而是把这个视图显示到当前视图下都某个标签下，则填写该标签的selector
			*@example
			*this.API.show("view1",data);
			*/
			showBack:function(__viewId,__target){
				//先将数据记录到本地存储中
				__data = _useAPI.lang.load("__viewId:"+__viewId);

				var target = _$app.dom;
				if (__target ){
					target = _$app.dom.find(__target);
					if (!target || target.length == 0){
						target = _$app.dom.find("#"+__target);
					}
					if (!target || target.length == 0){
						target = _$("#"+__target+"@"+_$app.id);
					}
					if (!target || target.length == 0){
						target = _$app.dom;
					}
				}
				var src = _$app.view[__viewId];
				if (src == null){
					target.html(__viewId);
					return;
				}
				//针对火狐把href中的${进行转移到处理
				src = src.replace(/(href=["'])([^"']+)(["'])/ig,
						function(all,a,b,c){
							return a+b.replace(/\$%7B/ig,function(a){return "${"}).replace(/%7D/ig,"}")+c;
						});
				var htmlStr = _useAPI.lang.parserTemplate(src,__data,_useAPI);
				//进行事件替换
				htmlStr = htmlStr.replace(/["]?\s*FireEvent\.(\w+)\(([^\)]*)\)\s*["]?/ig,function(a,b,c){
					var result = "\"var args=[" + c + "];";
					result += ("var app = $('#" + _$app.id + "')[0].app;");
					result += ("app.FireEvent." + b + ".apply(app,args)" + "\"");
					return result;
				});

				target.html(htmlStr);
				target.show();
			},
			/**
			*@function
			*@name append
			*@memberOf API
			*@description 显示追加append的方式，追加视图，即在本APP中显示一个指定的视图，视图即在html中，声明于app下的任何顶级带id的标签,建议这些标签id为view_前缀
			注意：追加的视图是不带标识视图自身的节点的。
			*@param {String} viewId 要显示的视图名称，某个顶级的标签的id
			*@param {Object} data 视图中使用的解析数据，在视图中将使用data引用这个对象
			*@param {String} target 视图显示的目标selector（jquery的selector），视图默认（即不填写该参数）将会把视图显示到app中，如果不是要覆盖当前视图，而是把这个视图显示到当前视图下都某个标签下，则填写该标签的selector
			*@example
			*this.API.append("view1",data);
			*/
			append:function(__viewId,__data,__target){
				var target = _$app.dom;
				if (__target ){
					 target = _$app.dom.find(__target);
					if (!target){
						target = _$app.dom;
					}
				}
				var src = _$app.view[__viewId];
				if (src == null){
					target.html(__viewId);
					return;
				}
				//针对火狐把href中的${进行转移到处理
				src = src.replace(/(href=["'])([^"']+)(["'])/ig,
						function(all,a,b,c){
							return a+b.replace(/\$%7B/ig,function(a){return "${"}).replace(/%7D/ig,"}")+c;
						});
				var htmlStr = _useAPI.lang.parserTemplate(src,__data,_useAPI);
				//进行事件替换
				htmlStr = htmlStr.replace(/["]?\s*FireEvent\.(\w+)\(([^\)]*)\)\s*["]?/ig,function(a,b,c){
					var result = "\"var args=[" + c + "];";
					result += ("var app = $('#" + _$app.id + "')[0].app;");
					result += ("app.FireEvent." + b + ".apply(app,args)" + "\"");
					return result;
				});



				var regStr = "<([^\\s]+)\\s+[^>]*?id=[\"']?"+__viewId+"[\"']?\\s*[^>]*>([\\s\\S]+)";
				var reg=new RegExp(regStr,"i");
				var execResult = reg.exec(htmlStr);

				if (execResult!= null){
					var tag = execResult[1];
					var remain = execResult[2];
					regStr = "([\\S\\s]+?)</"+tag+">\s*$";
					reg=new RegExp(regStr,"i");
					execResult = reg.exec(remain);
					if (execResult != null){
						htmlStr = execResult[1];
					}
				}

				target.append(htmlStr);
				target.show();
			},
			/**
			*@function
			*@name private
			*@memberOf API
			*@description 调用在private中声明的函数
			*@param {String} eventName 事件名称，和注册函数中的private下面的函数名相对应
			*@param [p1,p2,...] 后面可以一次增加对应的参数，与注册的TrigerEvent下的函数的声明参数相对应
			*@example
			*this.API.private('hello', 1,2,3);
			*那么，在gadget中，凡是声明为hello的函数将被触发：
			*private:{
			*  hello:function(a,b,c){
			*     //a is 1,b is 2,c is 3
			*  }
			*}
			*/
			private:function(evnName){
				var args = [];
				for (var i=1;i<arguments.length;i++){
					args.push(arguments[i]);
				}
				var app = _$app;
				if (app.private && app.private[evnName]) {
					return app.private[evnName].apply(app,args);
				}
			},
			/**
			*@function
			*@name trigerMyEvent
			*@memberOf API
			*@description 事件的触发器，使用该触发器，只触发自己这个APP中的TrigerEvent事件,不会触发别的gadet的事件
			*注意：本类中的TrigerEvent只能在通过这种方式调用，否则Triger中的this指针获取不到
			*@param {String} eventName 事件名称，和注册函数中的TrigerEvent下面的函数名相对应
			*@param [p1,p2,...] 后面可以一次增加对应的参数，与注册的TrigerEvent下的函数的声明参数相对应
			*@example
			*this.API.trigerEvent('hello', 1,2,3);
			*那么，在gadget中，凡是声明为hello的函数将被触发：
			*TrigerEvent:{
			*  hello:function(a,b,c){
			*     //a is 1,b is 2,c is 3
			*  }
			*}
			*/
			trigerMyEvent:function(evnName){
				var args = [];
				for (var i=1;i<arguments.length;i++){
					args.push(arguments[i]);
				}
				var app = _$app;
				app.TrigerEvent && app.TrigerEvent[evnName] && app.TrigerEvent[evnName].apply(app,args);
			},
			/**
			*@function
			*@name trigerOtherEvent
			*@memberOf API
			*@description 事件的触发器，使用该触发器，只触发非自己APP中的TrigerEvent事件,不会触发别的gadet的事件
			*注意：本类中的TrigerEvent只能在通过这种方式调用，否则Triger中的this指针获取不到
			*@param {String} eventName 事件名称，和注册函数中的TrigerEvent下面的函数名相对应
			*@param [p1,p2,...] 后面可以一次增加对应的参数，与注册的TrigerEvent下的函数的声明参数相对应
			*@example
			*this.API.trigerEvent('hello', 1,2,3);
			*那么，在其他gadget中，凡是声明为hello的函数将被触发：
			*TrigerEvent:{
			*  hello:function(a,b,c){
			*     //a is 1,b is 2,c is 3
			*  }
			*}
			*/
			trigerOtherEvent:function(evnName){
				var args = [];
				for (var i=1;i<arguments.length;i++){
					args.push(arguments[i]);
				}
				$(function(){
					for (var name in _app){
						if (!_app.hasOwnProperty(name)){
							continue;
						}
						var app = _app[name];
						if (app == _$app){
							continue;
						}
						app.TrigerEvent && app.TrigerEvent[evnName] && app.TrigerEvent[evnName].apply(app,args);
					}
				});
			},
			/**
			*@function
			*@name find
			*@memberOf API
			*@description 在本APP内，查找某个表单，使用的是jquery，返回的是container
			*@param {String} selector 要查找的jquery selector
			*@return {Container} 返回对应jquery查找的container
			*@example
			*this.API.find("#abc");
			*/
			find:function(__selector){
				return _$app.dom.find(__selector);
			},
			/**
			*@function
			*@name doServer
			*@memberOf API
			*@description 向服务器发起一个post的异步请求
			*@param {String} serverName 服务名
			*@param {String} package 所处包包名
			*@param {Object} param 要传递的参数对象
			*@param {Function} callback 异步请求结束后的回调函数，注意该函数的this已经 被重写，指向app，即gadget中服务函数的this
			*@example
			*this.API.doServer("getCms","cms",{nodeId:'-1'},
			*function(code,data){
			*	this.API.show("abc",data);
			*});
			*/
			doServer:function(__serverName,__package,__data,__callback){
				_obj.doServer(__serverName,__package,__data,__callback,_$app);
			},

			/**
			*@function
			*@name initPost
			*@memberOf API
			*@description 准备一个批量post请求对象
			*/
			initPost:function(){
				tmpPostObj = _createPost();
			},

			/**
			*@function
			*@name addPost
			*@memberOf API
			*@description 再initPost完成初始化后，添加一个服务请求，但是他不会立即发送，而是要等到doPost后才会批量触发
			*@param {String} serverName 服务名
			*@param {String} package 所处包包名
			*@param {Object} param 要传递的参数对象
			*@param {Function} callback 异步请求结束后的回调函数，注意该函数的this已经 被重写，指向app，即gadget中服务函数的this
			*@example
			*this.API.initPost();
			*this.API.addPost("getCms","cms",{nodeId:'-1'},
			*function(code,data){
			*	this.API.show("abc",data);
			*});
			*this.API.doPost();
			*/
			addPost:function(__serverName,__package,__data,__callback){
				if (tmpPostObj == null){
					alert('tmpPostObj is null please initPost first!');
					return;
				}
				var callbackThisObj = _$app;
				var postData = {
					name:__serverName,
					package:__package,
					param:__data,
					callBack:__callback,
					callbackThisObj:callbackThisObj
				}
				tmpPostObj.addPost(postData);
			},

			/**
			*@function
			*@name doPost
			*@memberOf API
			*@description 准当addPost结束后，真正触发发起请求
			*@param {function} __callBack 所有函数回调并执行完毕后的一个统一的回调函数
			*/
			doPost:function(__callBack){
				if (tmpPostObj == null){
					alert('tmpPostObj is null please initPost first!');
					return;
				}
				tmpPostObj.doPost(__callBack,_$app);
				tmpPostObj = null;
			},

			/**
			*@function
			*@name mask
			*@memberOf API
			*@description 使用遮罩弹出一个模式对话框
			*@param {String} viewId 要显示的viewid
			*@param {Object} view中使用data变量引用这个对象
			*@param {int} width 可选参数，弹出的框的宽度，如果不存在，使用view中maskwidth定义宽度
			*@param {int} height 可选参数，弹出的框的高度，如果不存在，使用view中maskheight定义高度
			*@example
			*this.API.mask("abc",data);
			*/
			mask:function(__viewId,__data,__width,__height){
				var src = _$app.view[__viewId];
				if (src == null){
					alert("view id " + __viewId + " not found!");
					return;
				}
				var htmlStr = _useAPI.lang.parserTemplate(src,__data,_useAPI);
				//进行事件替换
				htmlStr = htmlStr.replace(/["]?\s*FireEvent\.(\w+)\(([\w,']*)\)\s*["]?/ig,function(a,b,c){
					var result = "\"var args=[" + c + "];";
					result += ("var app = $('#" + _$app.id + "')[0].app;");
					result += ("app.FireEvent." + b + ".apply(app,args)" + "\"");
					return result;
				});
				var width = __width;
				var height = __height;
				if (width == null){
					var tmpExec = /maskwidth\s*=\s*['"]?(\d+)["']?/ig.exec(htmlStr);
					width = tmpExec && tmpExec[1];

					tmpExec = /maskheight\s*=\s*['"]?(\d+)["']?/ig.exec(htmlStr);
					height = tmpExec && tmpExec[1];
				}
				_obj.blockUI (htmlStr,($(window).width() - width) / 2,($(window).height() - height) / 2,width,height,'none');
			},
			/**
			*@function
			*@name unmask
			*@memberOf API
			*@description 关闭模式对话框
			*@example
			*this.API.unmask("abc",data);
			*/
			unmask:function(){
				_obj.unblockUI();
			}
		};
	}


	//下面开始是公有函数
	/**
	*@function
	*@name register
	*@memberOf FW
	*@description 用于注册业务gadget对象，即所说的业务代码，通常该类在业务代码第一行使用
	*@param {Object} c 要注册的业务gadget对象
	*@example
	*var FW = require("../framework/js/BreezeFW");
	*FW.register(
	*   {
	*		name:"该gadget的名称",
	*		onCreate:function(){
	*			//初始化部分
	*		},
	*		FireEvent:{
	*			//所有事件
	*		},
	*		TrigetEvent:{
	*			//所有触发点
	*		}
	*	}
	*)
	*/
	_obj.register =  function(__c){
		if (!__c || !__c.name){
			return;
		}

		_gadget[__c.name] = __c;
	};
	/**
	*@function
	*@name go
	*@memberOf FW
	*@description 用于注册业务gadget对象，即所说的业务代码，通常该类在业务代码第一行使用
	*@param {String} url 该框架中的doServer函数，的提交目标
	*@param {Objet} defObj 由外gadget自带的页面view实体信息，这个参数是可选的
	*@example
	*seajs.use(['/tools/service/processor'], function(a) {
	*			a.go("breeze/framework/php/BreezeFW.php");
	*		});
	*/
	_obj.go = function(__url,defObj,callBack){
		_doserverUrl = __url;
		//下面是初始化要调用的执行内容
		$(
			function(){
				_createInstances(defObj);
				for (var name in _app){
					_app[name].onCreate();
				};
				_allPost.doPost(callBack);
				_allPost = null;
			}
		);
	};
	/**
	*@name global
	*@memberOf FW
	*@description 在业务代码中，作为一个全局对象的容器
	*FW.global.a = {};
	*/
	_obj.global = {};

	/**
	*@function
	*@name trigerEvent
	*@memberOf FW
	*@description 框架事件的触发器，使用该触发器，那么注册的业务中的所有的TrigerEvent部分的函数，对应相同函数名的函数会被依次执行
	*@param {String} eventName 事件名称，和注册函数中的TrigerEvent下面的函数名相对应
	*@param [p1,p2,...] 后面可以一次增加对应的参数，与注册的TrigerEvent下的函数的声明参数相对应
	*@example
	*FW.trigerEvent('hello', 1,2,3);
	*那么，在被注册的gadget中，凡是声明为hello的函数将被触发：
	*TrigerEvent:{
	*  hello:function(a,b,c){
	*     //a is 1,b is 2,c is 3
	*  }
	*}
	*/
	_obj.trigerEvent = function(evnName){
		var args = [];
		for (var i=1;i<arguments.length;i++){
			args.push(arguments[i]);
		}
		seajs.log("BreezeFW.trigerEvent("+evnName+","+args.join(",")+")");
		$(function(){
			for (var name in _app){
				if (!_app.hasOwnProperty(name)){
					continue;
				}
				var app = _app[name];
				app.TrigerEvent && app.TrigerEvent[evnName] && app.TrigerEvent[evnName].apply(app,args);
			}
		});
	};

	/**
	*@function
	*@name use
	*@memberOf FW
	*@description 对外部能力扩展调用，有两种模式，注册模式，即把外部扩展注册进来，使用模式，即使用该类。注册模式通常给开发扩展功能程序员使用
	*@param {String|Object} p 如果是String类型，就是使用模式，即引入该域功能；如果是一个对象就是注册模式，将该域功能注册进来，参数为空默认为使用模式，使用默认的功能，即lang功能域
	*@example
	*使用模式：
	*require("tools/DataTime")(FW);
	*FW.use("DateTime").format();
	*/
	_obj.use = function (__p){
		if (__p == null){
			//这种情况就是用默认的域
			_useAPI.lang.FW = _obj;
			return _useAPI.lang;
		}
		if (/string/i.test(typeof(__p))){
			//说明是调用方式，返回这个域对应的对象
			_useAPI[__p].FW = _obj;
			return _useAPI[__p];
		}
		//说明是声明方式，设置这个域
		if (__p ){
			if (__p.getDomain){
				_useAPI[__p.getDomain()] = __p;
			}else{
				_useAPI.temp = __p;
			}
		}
	};

	/**
	*@function
	*@name doServer
	*@memberOf FW
	*@description 向服务器发起一个post的异步请求
	*@param {String} serverName 服务名
	*@param {String} package 所处包包名
	*@param {Object} param 要传递的参数对象
	*@param {Function} callback 异步请求结束后的回调函数，注意该函数的this已经 被重写，指向参数callbackThisObject
	*@param {Object} callbackThisObject 就是callback函数中的this指针，默认就是FW自己
	*@example
	*FW.doServer("getCms","cms",{nodeId:'-1'},
	*function(code,data){
	*	this.use("DateTime").format(data);
	*});
	*/
	_obj.doServer=function(__serverName,__package,__data,__callback,__callbackThisObj){
		var callbackThisObj = __callbackThisObj||_obj;
		var postData = {
			name:__serverName,
			package:__package,
			param:__data,
			callBack:__callback,
			callbackThisObj:callbackThisObj
		}
		//第一次运行的时候，一起加载，其余的时候，单独加载
		if (_allPost){
			_allPost.addPost(postData);
		}else{
			var temp = _createPost();
			temp.addPost(postData);
			temp.doPost();
		}
	};
	/**
	*@function
	*@name blockUI
	*@memberOf FW
	*@description 建立一个模式对话框
	*@param {String} src 模式对话框的html内容
	*@param {int} left 左边距坐标
	*@param {int} top 对象上边距坐标
	*@param {int} width 宽度
	*@param {int} height 高度
	*@param {String} 边框例如'none'
	*/
	_obj.blockUI = function(__src,__left,__top,__width,__height,__border){
		$.blockUI({
			message: __src,
			css: {
				width: __width+'px',
				height: __height+'px',
				left: __left + 'px',
				top: __top + 'px',
				border: __border
			}
		});
	};



	/**
	*@function
	*@name unblockUI
	*@memberOf FW
	*@description 解除模式对话框
	*/
	_obj.unblockUI = function(){
		$.unblockUI();
	};


	//私有函数
	var _createInstances = function(defObj){
		if (defObj){
			_createInstancesByDefObj(defObj);
		}else{
			_createInstancesByHtmlDom();
		}
	};
	var _createInstancesByDefObj = function(defObj){
		//先解析app
		for (var appName in defObj){
			if (!defObj.hasOwnProperty(appName)){
				continue;
			}
			var inId = appName;
			var appDefObj = defObj[appName];
			if (appDefObj.type != null && /container/i.test(appDefObj.type)){
				continue;
			}
			if (appDefObj.appClass == null){
				seajs.log("class defind not found:");
				continue;
			}

			var classObj = _gadget[appDefObj.appClass];
			if (classObj == null){
				seajs.log("class not found :"+appDefObj.appClass);
				return;
			}
			var param = appDefObj.param;
			//下面组装新的APP
			var app = _app[inId] = $("#"+appName)[0].app = {};
			app.id = inId;

			app.dom = $("#"+app.id);
			//复制所有class
			for (var name in classObj){
				if (classObj.hasOwnProperty(name)){
					app[name] = classObj[name];
				}
			};
			//加入系统参数
			app.param = param;
			//加入每个应用的视图,所以class 为 AppView的作为视图，而且id作为视图id
			app.view = {};
			for(var viewName in appDefObj.view){
				if (!appDefObj.view.hasOwnProperty(viewName)){
					continue;
				}
				var HTMLfunction = appDefObj.view[viewName];
				if (!HTMLfunction){
					seajs.log("can not read view :"+viewName);
					continue;
				}
				//到时补充替换事件处理能力
				var inhtml = HTMLfunction();
				app.view[viewName] = inhtml;
			};
			//绑定工具
			app.API = _createFWTools(app);
			//创建自定函数对象
			app.MY = {};
		}
	};

	/*
	*这是一个神奇的函数，将根据当前加载的页面，将所有的类实例化，当然前提是该类存在
	*这里不需要任何显示的输入参数
	*所有参数来自页面约定好的格式，约定的形式如下：
	*1. 页面上所有class是FWApp的都是一个具体的APP实体，或者是容器实体
	*2. 该标签的ID就是对应实例ID
	*3. 该标签有一段注释是以<!--@classname@开头的其内容是一个json的完整注释就是一个完整的该APP的参数
	*4. 该参数将被转换成一个appparam的成员内容
	*5. 该方法将原来的class和appparam一起转成一个新的实例并丢到_app里面
	*新增处理解析容器能力，容器是一个由一个主APP加上若干个容器特定API构成。容器API仅仅对外提供容器内部APP的现实隐藏功能。
	*容器采用class=FWContainer形式，容器的dom的id和主app的id相同，建立好关联后，需要将容器的id属性删除掉
	*/
	var _createInstancesByHtmlDom = function(){
		//先解释和处理APP的
		$.each($(".FWApp"),function(){
			var inId = this.id;
			var htmlStr = $(this).html();
			//取里面的系统配置参数
			var execResult =  /<!--\s*@(\s*[^@]+)\s*@([\s\S]+?)-->/.exec(htmlStr);
			if (execResult == null){
				seajs.log("param defind not found:"+inId);
				return;
			}
			var classObj = _gadget[execResult[1]];
			if (classObj == null){
				seajs.log("class not found :"+execResult[1]);
				return;
			}
			var param = eval("(" + execResult[2] +")");
			//下面组装新的APP

			/**
			 * @namespace
			 * @author Alec
			 * @name APP
			 * @description 这是app对象，而在我们FW里面注册的gadget实际上用this代表了一个具体的APP
			 */
			var app = _app[inId] = this.app = {};
			/**
			 * @name id
			 * @memberOf APP
			 * @description APP的id
			 */
			app.id = inId;


			/**
			 * @name dom
			 * @memberOf APP
			 * @description 这个APP代表的html的dom节点，注意，不是jquery的container
			 */
			app.dom = $(this);
			//复制所有class
			//先创建一个深度复制到内部函数2013-10-09
			var deepCopy = function(__root, __srcObj, __destObj, __path) {
				for (var name in __srcObj) {
					if (!__srcObj.hasOwnProperty(name)) {
						continue;
					}
					var oo = __srcObj[name];
					if (/function/i.test(typeof(oo))) {
						//如果是函数就支持接赋值了,并下一个
						if (__path != null) {
							__root[__path + "_" + name] = oo;
						}
						//2013-11-15日lgy修改，函数也要进行覆盖性判断，如果目标子类存在就不用父类的方法
						if (__destObj[name] == null){
							__destObj[name] = oo;
						}
						continue;
					}
					if (/Object/i.test(typeof(oo))) {
						if (__destObj[name] == null) {
							__destObj[name] = oo;
						}
						//递归调用对对象
						if (__path != null) {
							deepCopy(__root, oo, __destObj[name], __path + "_" + name);
						} else {
							deepCopy(__root, oo, __destObj[name], null);
						}
						continue;
					}
					//lgy 2013-11-13 子类如果存在对应的值就不能用父类覆盖。这里oo是父类的值
					if (__destObj[name] == null){
						__destObj[name] = oo;
					}
				}
			};
			//找出所有父类，说明当前偷懒，隔代继承暂时不实现
			/**
			 * @name extends
			 * @memberOf APP
			 * @description APP的继承信息，在编写gadget的时候重写。
			 *  继承的规则是，被继承的当前gadget会复盖父类相同的同名方法，以及同名参数。而没有复盖的部分
			 *  将使用父类的方法。
			 *  另外，通过[fatherGadget]_{FireEvent,private,TrigerEvent}_[functionName]的方式可以调用到父类的方法
			 *  继承的使用方式：在gadget中声明extends:[fatherGadget1,fatherGadget2...]
			 */
			 //这个方法是否辅助的临时方法，协助返回一个类，且这个类是完全已经实现继承机制了的
			var getAfterExtendGadget = function(__gadgetObj) {
				var result = __gadgetObj;
				if (result.extends) {
					for (var i = 0; i < result.extends.length; i++) {
						var oneClassName = result.extends[i];
						var oneClass = getAfterExtendGadget(_gadget[oneClassName]);
						deepCopy(result, oneClass, result, oneClassName);
					}
				}
				return result;
			}
			classObj = getAfterExtendGadget(classObj);
			//最后再处理当前的app
			deepCopy(app,classObj,app,null);

			/**
			 * @name param
			 * @memberOf APP
			 * @description 在该APP中声明的参数
			 */
			//把APP里面的默认值复制过去
			if (app.param){
				for (var m in app.param){
					if (!param[m]){
						param[m] = app.param[m];
					}
				}
			}
			app.param = param;
			/*
			if (classObj.param){
				for (var m in classObj.param){
					if (!app.param[m]){
						app.param[m] = classObj.param[m];
					}
				}
			}
			*/

			/**
			 * @name view
			 * @memberOf APP
			 * @description 加入每个应用的视图,key是视图id，value是视图字符串
			 */
			app.view = {};
			$.each($(this).children(),function(){
				if(this.id ==''){
					return;
				}
				var regStr = "<"+this.tagName+"\\s+[^>]*?id=[\"']?"+this.id+"[\"']?\\s*[^>]*>";
				var reg=new RegExp(regStr,"i");
				var execResult = reg.exec(htmlStr);
				var head = "";
				var tail = "";
				if (execResult!= null){
					head = execResult[0];
					tail = "</"+this.tagName+">";
					//alert(head+tail);
				}
				//到时补充替换事件处理能力
				var inhtml = $(this).html();
				inhtml = inhtml.replace(/&lt;!--/ig,"<!--").replace(/--&gt;/ig,"-->");
				app.view[this.id] = head+inhtml+tail;
			});
			/**
			 * @name API
			 * @memberOf APP
			 * @description 应用于该APP中的每一个API函数
			 * @see API
			 */
			app.API = _createFWTools(app);
			//创建自定函数对象
			/**
			 * @name MY
			 * @memberOf APP
			 * @description 用于扩展，即留给每个APP由用户自定义的函数或类对象
			 */
			app.MY = {};
			$(app.dom).html("");
		});
		//然后解析和处理容器的
		$.each($(".FWContainer"),function(){
			//记录信息并把ID改掉
			var idx = this.id;
			$(this).removeAttr("id");
			var mainapp = _app[idx];
			if (!mainapp){
				seajs.log("BreezeFW._createInstances:main app is not exist id is:" + idx);
				return;
			}
			var container = _container[idx] = mainapp.container = {};
			container.appArray = [];
			//下面收集容器里面的app信息
			$(this).find(".FWApp").each(function(){
				if (this.id == idx){
					//这是主APP，忽略
					return;
				}
				var innerApp = _app[this.id];
				innerApp.dom.css("display","none");//出事情况下，不显示
				if (!innerApp){
					seajs.log("BreezeFW._createInstances:app is not exist id is:" + this.id);
					return;
				}
				container.appArray.push(innerApp);
			});

			//下面给mainapp增加函数
			mainapp.API.CShow = function(id){
				if (/string/i.test(id)){
					//如果是字符串，那么就是取ID
					for (var i=0;i<container.appArray.length;i++){
						if (container.appArray[i].id == id){
							container.appArray[i].dom.css("display","");
							break;
						}
					}
				}else{
					container.appArray[id].dom.css("display","");
				}
			};
			mainapp.API.CShowOnly = function(id){
				if (/string/i.test(id)){
					//如果是字符串，那么就是取ID
					for (var i=0;i<container.appArray.length;i++){
						if (container.appArray[i].id == id){
							container.appArray[i].dom.css("display","");
						}else{
							container.appArray[i].dom.css("display","none");
						}
					}
				}else{
					for (var i=0;i<container.appArray.length;i++){
						if (i == id){
							container.appArray[i].dom.css("display","");
						}else{
							container.appArray[i].dom.css("display","none");
						}
					}
				}
			};
		});
	};


});