/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name voucherListGadget
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
        "alias": "voucher"
      },
      name: "voucherListGadget",
      extends: ["cmsMgrGadget"],
      private:{
        privateMessConListOk:function(_data){
        },
        privateBtnConEdit: function(_dom,_data){
          var hash = '/page/manager/voucher_edit.jsp?cid='+_data.cid+'&action=conEdit';
          window.location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        }
      },
      FireEvent:{
      },
      TrigerEvent:{
        trigerVoucherAdd: function(){
          var hash = '/page/manager/voucher_edit.jsp?action=conAdd';
          window.location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        }
      }
    }
  );
  return FW;
});

