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
        alias: 'orders'
      },
      name:"ordersEditExtGadget",
      extends:["cmsMgrGadget"],
      FireEvent:{
      },
      private:{
        privateSetDescAndData: function(_alias,_data,_callback){
          var _this = this;
          var _desc = _this.MY.contentDesc[_alias];
          // status 成交状态处理
          var statusMap = {
            "1": [1,2],
            "2": [2,3],
            "3": [3,4],
            "4": [4],
            "5": [5,6],
            "6": [6],
            "7": [7]
          };
          var c_status_data = _data.status || 0;
          var c_status_desc = _desc.status.valueRange[0];
          var selopt = {};
          var smap = {};
          $.each(c_status_desc, function(k,v){
            smap[v] = k;
          });
          $.each(statusMap[c_status_data], function(i,v){
            selopt[smap[v]] = v;
          });
          _desc.status.valueRange = [selopt];
          if(c_status_data==2){
            _desc.status.desc = ' 更新到已发货状态，请完善发货信息';
          }
          // actinfo 处理
          try{
            var actinfoData = _data.actinfo?FW.use().evalJSON(_data.actinfo):{};
            var voucherinfoData = _data.voucherinfo?FW.use().evalJSON(_data.voucherinfo):{};
          }catch(err){
            var actinfoData = {};
            var voucherinfoData = {};
          }
          var actinfoMap = {
            id: '活动ID',
            title: '活动标题',
            discount: '享受折扣',
            price: '优惠价格'
          };
          var voucherinfoMap = {
            id: '红包ID',
            money: '红包金额'
          };
          _desc.actinfo.desc = _desc.voucherinfo.desc = "";
          if(actinfoData.id) _desc.actinfo.desc += actinfoMap.id+"："+actinfoData.id+"； ";
          if(actinfoData.title) _desc.actinfo.desc += actinfoMap.title+"："+actinfoData.title+"； ";
          if(actinfoData.discount) _desc.actinfo.desc += actinfoMap.discount+"："+actinfoData.discount+"折； ";
          if(actinfoData.price) _desc.actinfo.desc += actinfoMap.price+"："+actinfoData.price+"元； ";
          if(voucherinfoData.id) _desc.voucherinfo.desc += voucherinfoMap.id+"："+voucherinfoData.id+"； ";
          if(voucherinfoData.money) _desc.voucherinfo.desc += voucherinfoMap.money+"："+voucherinfoData.money+"元； ";
          if(!_desc.actinfo.desc) _desc.actinfo.desc = "无";
          if(!_desc.voucherinfo.desc) _desc.voucherinfo.desc = "无";

          _this.API.initPost();
          var skuHtml = [];  //销售属性
          var feaHtml = [];  //普通属性
          var skuArr = [];
          var feaArr = [];
          //item_sku处理
          if(_data.item_sku && _data.item_sku.split(':').length===2){
            skuArr = _data.item_sku.split(':')[1].split(',');
          }
          //feature处理
          if(_data.feature){
            feaArr = _data.feature.split(',');
          }
          if(!skuArr.length && !feaArr.length){
            tocb();
            return;
          }

          getCpv(skuArr, skuHtml);
          getCpv(feaArr, feaHtml);

          _this.API.doPost(function(){
            tocb();
          });
          function tocb(){
            _desc.item_sku.desc = skuHtml.length?skuHtml.join('； '):'无';
            _desc.feature.desc = feaHtml.length?feaHtml.join('； '):'无';
            _callback && _callback();
          }
          function getCpv(cpvArr, strArr){
            $.each(cpvArr,function(i,cid){
              _this.API.addPost('queryContent','cms',{
                alias: 'category_property_values',
                param:{
                  cid: cid
                }
              },function(code,data){
                if(code==0&&data.cmsdata){
                  var d = data.cmsdata[0];
                  strArr.push(d.property_name+'：'+d.value);
                }
              });
            })
          }
        },
        privateMessConEditOk:function(data){
          top.location.hash = location.pathname+location.search;
          var _this = this;
          //获得dom
          var formDom = _this.API.find("#"+_this.param.formConEdit);
          formDom.find('input,select,textArea').each(function(){
            var name = $(this).attr('name');
            var editField = ['data.sender_address','data.send_type','data.send_id','data.send_time'];
            if($.inArray(name, editField) != -1 && data.status==2) return true;
            if(name!='data.status') $(this).attr('disabled','true');
          });
        }
      },
      TrigerEvent:{
        trigerSubmit: function(){
          var _this = this;
          //列表提交
          _this.API.private("privateSubmitConEdit",function(){
            FW.use('Widget').alert("修改完成!");
            setTimeout(function(){
              location.href = Cfg.baseUrl+'/page/manager/orders_list.jsp';
            },2000);
          });
        },
        trigerGoBack: function(){
          location.href = Cfg.baseUrl+'/page/manager/orders_list.jsp';
        }
      }
    }
  );
  return FW;
});

