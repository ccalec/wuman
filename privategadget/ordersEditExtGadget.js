/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name ordersEditExtGadget
* @description  CMS后台内容操作视图的扩展函数Gadget
*/

define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  require("../gadget/cmsMgrGadget"); //引入扩展函数
  FW.register(
    {
      param:{
      },
      name:"ordersEditExtGadget",
      extends:["cmsMgrGadget"],
      FireEvent:{
      },
      private:{
      },
      TrigerEvent:{
        trigerSubmit: function(){
          var _this = this;
          //列表提交
          _this.API.private("privateSubmitConEdit",function(){
            FW.use('Widget').alert("修改完成!");
            setTimeout(function(){
              location.href = Cfg.baseUrl+'/page/manager/orders_list.jsp?norole=true';
            },2000);
          });
        },
        trigerGoBack: function(){
          location.href = Cfg.baseUrl+'/page/manager/orders_list.jsp?norole=true';
        }
      }
    }
  );
  return FW;
});

