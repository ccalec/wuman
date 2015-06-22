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
        privateSetDescAndData: function(_alias,_data,_callback){
          var _this = this;
          var _desc = _this.MY.contentDesc[_alias];

          _this.API.initPost();

          //item_sku处理
          if(_data.item_sku && _data.item_sku.split(':').length===2){
            var skuHtml = [];  //销售属性
            var cpvArr = _data.item_sku.split(':')[1].split(',');
            getCpv(cpvArr, skuHtml);
          }
          //feature处理
          if(_data.feature){
            var feaHtml = [];  //普通属性
            var cpvArr = _data.feature.split(',');
            getCpv(cpvArr, feaHtml);
          }

          _this.API.doPost(function(){
            _desc.item_sku.desc = skuHtml.join('； ');
            _desc.feature.desc = feaHtml.join('； ');
            _callback && _callback();
          });

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
          var _this = this;
          //获得dom
          var formDom = _this.API.find("#"+_this.param.formConEdit);
          formDom.find('input,select,textArea').each(function(){
            var name = $(this).attr('name');
            var editField = ['data.status','data.sender_address','data.send_type','data.send_id','data.send_time'];
            if($.inArray(name, editField) ==-1){
              $(this).attr('disabled','true');
            }
          })
        }
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

