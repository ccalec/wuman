/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://www.wgfly.com">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name cmsMgrExtGadget
* @description  CMS后台内容操作视图的扩展函数Gadget
*/

define(function(require, exports, module) {
	var FW = require("../breeze/framework/js/BreezeFW");
	require("../breeze/framework/js/tools/DateTime")(FW);
	require("../gadget/cmsMgrGadget"); //引入扩展函数
	FW.register(
		{
			param:{

			},
			name:"cmsMgrExtGadget",
			extends:["cmsMgrGadget"],
			FireEvent:{
			},
			private:{
				privateSetRoles:function(_dom,_data){
					document.location.href = "rolesAction.jsp?nodeid="+_data.cid;
				}
			},
			TrigerEvent:{

			}
		}
	);
	return FW;
});

