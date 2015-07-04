/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name activitiesListGadget
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
        "alias": "activities"
      },
      name: "activitiesListGadget",
      extends: ["cmsMgrGadget"],
      private:{
        privateBtnConEdit: function(_dom,_data){
          var hash = '/page/manager/activities_edit.jsp?cid='+_data.cid+'&action=conEdit';
          window.location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        }
      },
      FireEvent:{
      },
      TrigerEvent:{
        trigerActAdd: function(){
          // 弹出层
          var _this = this;
          var _desc = _this.MY.contentDesc[_this.MY.alias];
          var htmlstr = _this.API.getHtml('viewActAdd', {typeObj: _desc.activity_type.valueRange[0]});
          FW.use('Widget').prompt(htmlstr, '选择活动类型', function(){
            var type = $('#J_activities_type').val();
            var hash = '/page/manager/activities_edit.jsp?action=conAdd&type='+type;
            window.location.href = Cfg.baseUrl+hash;
            top.location.hash = Cfg.baseUrl+hash;
          },true);
        }
      }
    }
  );
  return FW;
});

