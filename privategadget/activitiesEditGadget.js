/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name activitiesEditGadget
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
        alias: 'activities'
      },
      name:"activitiesEditGadget",
      extends:["cmsMgrGadget"],
      FireEvent:{
      },
      private:{
        privateSetDescAndData: function(_alias,_data,_callback){
          var _this = this;
          var _desc = _this.MY.contentDesc[_alias];
          //判断类型，分别做不同的处理
          var type = _data.activity_type = _data.activity_type || FW.use().getParameter("type");
          if(type==1){ //123折
            _desc.discount.title="活动规则";
            _desc.discount.type="";
            _desc.discount.desc="单个账号，第一次购买活动内商品享受1折折扣，第二次购买活动内商品享受2折折扣，第三次购买购买活动内商品享受3折折扣。";
            _desc.price.type = 'Hidden';
          }else
          if(type==2){ //今日特卖
            _desc.discount.title="活动规则";
            _desc.discount.desc="折优惠";
            _desc.price.type = 'Hidden';
          }else
          if(type==3){
            _desc.price.title="活动规则";
            _desc.discount.type = 'Hidden';
          }
          _callback && _callback();
        },
        privateMessConEditOk:function(data){
          var _this = this;
          var type = data.activity_type;
          _this.API.private('privateDoform',type);
          //禁止修改部分
          var formDom = _this.API.find("#"+_this.param.formConEdit);
          formDom.find('input,select,textArea').each(function(){
            var name = $(this).attr('name');
            var editField = [];
            if($.inArray(name, editField) != -1 && data.status==2) return true;
            $(this).attr('disabled','true');
          });
        },
        privateMessConAddOk:function(data){
          var _this = this;
          var type = data.activity_type;
          _this.API.private('privateDoform',type);
          //禁止修改部分
          _this.API.find('._activity_type_sel').attr('disabled','true');
        },
        privateDoform: function(type){
          if(type==1){ //123折
          }else
          if(type==2){ //今日特卖
            this.API.find('._discount_inp').width(50).before('活动时间内商品，享受 ');
          }else
          if(type==3){
            this.API.find('._price_inp').width(50).before('参加此活动商品出售价格皆为 ');
          }
        }
      },
      TrigerEvent:{
        trigerSubmit: function(){
          var _this = this;
          //编辑
          if(_this.MY.action == _this.MY.act.conEdit){
            _this.API.private("privateSubmitConEdit",function(){
              FW.use('Widget').alert("修改完成!");
              setTimeout(function(){
                var hash = '/page/manager/activities_list.jsp';
                location.href = Cfg.baseUrl+hash;
                top.location.hash = Cfg.baseUrl+hash;
              },2000);
            });
          }
          // 新增
          if(_this.MY.action == _this.MY.act.conAdd){
            _this.API.private("privateSubmitConAdd",function(){
              FW.use('Widget').alert("添加完成!");
              setTimeout(function(){
                var hash = '/page/manager/activities_list.jsp';
                location.href = Cfg.baseUrl+hash;
                top.location.hash = Cfg.baseUrl+hash;
              },2000);
            });
          }
        },
        trigerGoBack: function(){
          var hash = '/page/manager/activities_list.jsp';
          location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        }
      }
    }
  );
  return FW;
});

