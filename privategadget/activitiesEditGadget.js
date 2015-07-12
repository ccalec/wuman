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
          //判断是否活动开始，显示提示文案
          if(_data.start_time < new Date().getTime()){
            _desc.activity_type.desc = '<span style="color:red">活动已经开始，禁止任何修改</span>';
          }
          //处理add_time
          _data.add_time = _data.add_time || (new Date().getTime()).toString();
          //添加参与活动的宝贝
          if(_this.MY.action===_this.MY.act.conAdd){
            var agdesc = '<a style="margin-left:-5px;" class="btn btn-mini btn-info" href="javascript:void(0);" onclick="FW.trigerEvent(\'trigerActGoods\',\'ADD\')"><i class="icon-plus bigger-120"> 点击添加</i></a><span id="idsdesc"></span>';
          }else{
            var agdesc = '<a style="margin-left:-5px;" class="btn btn-mini btn-info" href="javascript:void(0);" onclick="FW.trigerEvent(\'trigerActGoods\',\'MGR\')"><i class="icon-edit bigger-120"> 管理宝贝</i></a><span id="idsdesc"></span>';
          }
          _desc.actgoods = {
            title: '参与活动宝贝',
            type: '',
            desc: agdesc
          };
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
          //类型永远禁止
          $('._activity_type_sel,input[name="data.add_time"]').attr('disabled','true');
          //如果活动开始，禁止修改其他字段
          if(data.start_time < new Date().getTime()){
            var formDom = _this.API.find("#"+_this.param.formConEdit);
            formDom.find('input,select,textArea').each(function(){
              $(this).attr('disabled','true');
            });
            $('.date-time-picker .add-on').remove();
            $('#submitBtn>a:eq(0)').remove();
          }
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
        },
        privateActGoodsSubmit: function(cid){
          var _this = this;
          if(_this.MY.ids){
            _this.API.initPost();
            if(_this.MY.ids.del.length){
              $.each(_this.MY.ids.del, function(i,item_id){
                var _param = {
                  alias: 'activity_items',
                  param: {
                    item_id: item_id,
                    nodeid: cid
                  }
                };
                _this.API.addPost('deleteContent', 'cms', _param, function(code,data){
                  if(code!==0){
                    FW.use('Widget').alert("取消宝贝失败！");
                  }
                })
              });
            }
            if(_this.MY.ids.add.length){
              $.each(_this.MY.ids.add, function(i,item_id){
                var _param = {
                  alias: 'activity_items',
                  param: {
                    item_id: item_id,
                    nodeid: cid,
                    add_time: new Date().getTime()
                  }
                };
                _this.API.addPost('addContent', 'cms', _param, function(code,data){
                  if(code!==0){
                    FW.use('Widget').alert("添加宝贝失败！");
                  }
                })
              });
            }
            _this.API.doPost(function(){
              callback();
            })
          }else{
            callback();
          }
          function callback(){
            if(_this.MY.action == _this.MY.act.conEdit){
              FW.use('Widget').alert("编辑成功!");
            }else{
              FW.use('Widget').alert("添加成功!");
            }
            setTimeout(function(){
              var hash = '/page/manager/activities_list.jsp';
              location.href = Cfg.baseUrl+hash;
              top.location.hash = Cfg.baseUrl+hash;
            },2000);
          }
        }
      },
      TrigerEvent:{
        trigerSubmit: function(){
          var _this = this;
          //编辑
          if(_this.MY.action == _this.MY.act.conEdit){
            _this.API.private("privateSubmitConEdit",function(){
              _this.API.private('privateActGoodsSubmit',_this.MY.cid);
            });
          }
          // 新增
          if(_this.MY.action == _this.MY.act.conAdd){
            _this.API.private("privateSubmitConAdd",function(data){
              _this.MY.cid = data[1];
              _this.API.private('privateActGoodsSubmit',data[1]);
            });
          }
        },
        trigerGoBack: function(){
          var hash = '/page/manager/activities_list.jsp';
          location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        },
        trigerActGoods: function(type){
          var _this = this;
          var w = $(window).width()-100;
          var h = $(window).height()-120;
          var htmlstr = '<div style="background:#fff; width:'+w+'px; height:'+h+'px;" id="J_actgmask"></div>';
          var titlestr = '<div class="pull-left">管理参与活动的宝贝</div><div class="widget-toolbar no-border" style="margin-left: 50px;">'+
                            '<ul class="nav nav-tabs" id="myTab">'+
                              '<li><a data-toggle="tab" href="javascript:void(0)" onclick="FW.trigerEvent(\'trigerShowAct\',\'MGR\')"><i class="icon-check"></i> 管理已选宝贝(<b>0</b>)</a></li>'+
                              '<li><a data-toggle="tab" href="javascript:void(0)" onclick="FW.trigerEvent(\'trigerShowAct\',\'ADD\')"><i class="icon-plus"></i> 添加宝贝(<b>0</b>)</a></li>'+
                            '</ul>'+
                          '</div>';

          FW.use('Widget').prompt(htmlstr,titlestr,function(){
            $('#idsdesc').html($('#searchForList').html());
            $.unblockUI();
            $('#J_actgoodscon').hide().appendTo($('body'));
            $('#submitBtn').show();
          },function(){
            $('#idsdesc').html($('#searchForList').html());
            $.unblockUI();
            $('#J_actgoodscon').hide().appendTo($('body'));
            $('#submitBtn').show();
          });
          $('#J_actgoodscon').appendTo($('#J_actgmask')).show();
          FW.trigerEvent('trigerShowAct',type, _this.MY.cid);
        },
        trigerActGoodsRes: function(ids){
          this.MY.ids = ids;
        }
      }
    }
  );
  return FW;
});

