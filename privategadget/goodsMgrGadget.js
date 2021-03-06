
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../gadget/cmsMgrGadget");
  FW.register(
    {
      param:{
        alias:'goods'
      },
      name:'goodsMgrGadget',
      extends:["cmsMgrGadget"],
      FireEvent:{
        step1btn: function(){
          if(this.MY.nodeid) {
            this.API.private('privateStep2');
          }
        }
      },
      private:{
        privateShowDefaultView: function(){
          if((this.MY.action == this.MY.act.conEdit && this.MY.cid) || (this.MY.action == this.MY.act.conAdd && this.MY.nodeid)){
            this.API.private('privateStep2');
          }else{
            // 显示默认视图
            this.API.private('privateStep1');
          }
        },
        privateStep1: function(){
          var _this = this;
          _this.API.private('privateSetNavbar',1);
          _this.API.private('privateGetCateList', 0, function(cateList){
            _this.API.show('viewGoodsMgrStep1');
            top.location.hash = Cfg.baseUrl+location.pathname;

            _this.API.show('viewCateListTPL', {cateList: cateList}, 'parentList', false);

            // 绑定点击事件
            var navArr = [];
            _this.API.find('#parentList').delegate('li','click',function(){
              _this.API.find('.arrow i').attr('class','icon-spinner icon-spin bigger-200');
              $(this).addClass('active').siblings().removeClass('active');
              _this.API.find('#btnStep1 a').addClass('disabled');
              _this.MY.sonCateId = '';
              navArr = [];
              navArr[0] = $(this).text();
              _this.MY.parentCateId = $(this).attr('data-cid');
              _this.API.private('privateGetCateList', _this.MY.parentCateId, function(cateList){
                  _this.API.find('.arrow i').attr('class','icon-angle-right bigger-200');
                  _this.API.show('viewCateListTPL',{cateList: cateList},'sonList');
                  _this.API.find('#restxt').html(navArr.join(' &gt; '));
              });
            });
            _this.API.find('#sonList').delegate('li','click',function(){
              _this.MY.nodeid = $(this).attr('data-cid');
              navArr[1] = $(this).text();
              $(this).addClass('active').siblings().removeClass('active');
              _this.API.find('#restxt').html(navArr.join(' &gt; '));
              _this.API.find('#btnStep1 a').removeClass('disabled');
            });
          });
        },
        privateStep2: function(){
          var _this = this;
          _this.API.private('privateSetNavbar',2);
          if(this.MY.act.conEdit && this.MY.cid){
            _this.API.private('privateShowConEdit'); //显示编辑视图
            top.location.hash = location.pathname+'?nodeid='+this.MY.nodeid+'&cid='+this.MY.cid+'&action=conEdit';
          }else{
            _this.API.private('privateShowConAdd'); //显示添加视图
            FW.trigerEvent("triggerShowSkuView", this.MY.cid, this.MY.nodeid);
            top.location.hash = location.pathname+'?nodeid='+this.MY.nodeid+'&action=conAdd';
          }
          // 货物编号增加同步按钮,绑定同步事件
          _this.API.private('privateUpdateGoods');

        },
        privateMessConEditOk:function(data){
          FW.trigerEvent("triggerShowSkuView", this.MY.cid, this.MY.nodeid, data.feature);
        },
        privateUpdateGoods: function(){
          var _this = this;
          var statusBtn =  false;
          $('#goodsMgrGadget').delegate('.J_updateGoodsInfo','click', function(e){
            var $this = $(this);
            var goodsno = $this.parents('.controls').find('input').val();
            if(!goodsno) {
              $this.parents('.controls').addClass('error');
              $this.removeClass('btn-success').addClass('btn-danger');
              return;
            }
            if(statusBtn) return;
            var statusBtn =  true;
            $this.find('i').attr('class','icon-spinner icon-spin bigger-120');  //增加loading
            var param = {
              alias: _this.param.alias,
              param: {
                goodsno: goodsno,
                nodeid: _this.MY.nodeid
              }
            };
            _this.API.doServer("queryContent", "cms", param, function(code,data){
              if(code==0 && data && data.cmsdata){
                _this.MY.cid = data.cmsdata[0].cid;
                _this.MY.nodeid = data.cmsdata[0].nodeid;
                _this.API.private('privateShowConEdit'); //显示编辑视图
                top.location.hash = location.pathname+'?nodeid='+this.MY.nodeid+'&cid='+this.MY.cid+'&action=conEdit';
              }else{
                $this.find('i').attr('class','icon-refresh bigger-120');  //去掉loading
                $this.parents('.controls').removeClass('error');
                $this.removeClass('btn-danger').addClass('btn-success');
              }
              var statusBtn =  false;
            });
          });
        },
        privateGetCateList: function(nodeid, callback){
          var _this = this;
          // 获取一级类目
          var param = {
            alias: _this.param.alias,
            param: {
              nodeid: nodeid
            },
            spes: {
              orderby:[{
                name:"sort_order",
                desc:"true"
              },{
                name:"cid",
                desc:"true"
              }]
            }
          };
          _this.API.doServer("queryNode", "cms", param, function(code,data){
            if(code!==0 || !data || !data.cmsdata){
              FW.use('Widget').alert('类目查询失败！');
              return;
            }
            callback && callback(data.cmsdata);
          });
        },
        privateSetNavbar: function(num){
          $('.goods_nav li').eq(num-1).addClass('current').siblings().removeClass('current');
        },
        privateFormToData: function(_desc,_data){
          var _this = this;
          //转换_data中数组字符串的情况为数组
          if(_data){
            // feature
            var feature = [];
            $('.J_commmon_property select').each(function(){
              feature.push($(this).val());
            });
            _data.feature = feature.join(',');
            //库存 quantity， 如果存在sku库存，则替换为sku库存总和
            var totalQuantity = 0;
            $("#J_skuform input[name='quantity']").each(function(){
              totalQuantity +=  parseInt($(this).val());
            })
            if(totalQuantity) _data.quantity = totalQuantity.toString();
            for(var v_prop in _desc){
              if($.inArray(_desc[v_prop].type, ['List','Pics']) != -1){
                if(!_data[v_prop]) continue;
                _data[v_prop] = FW.use().toJSONString(_data[v_prop]);
              }
            }
          }
        },
        privateSetDescAndData: function(_alias,_data,_callback){
          var _this = this;
          var _desc = _this.MY.contentDesc[_alias];
          _this.API.doServer('searchCategoryByCid', 'goods', {cid: _data.nodeid}, function(code,data){
            if(code==0&&data){
              _desc.nodeid.desc = data[0].root_catname+" - "+data[0].parent_catname;
            }
            //给上下架默认时间
            if(_this.MY.action === 'conAdd'){
              _data.start_time  = (new Date().getTime()).toString();
              _data.end_time  = (new Date().getTime()).toString();
            };
            _callback && _callback();
          });
        }
      },
      TrigerEvent:{
        trigerSubmit: function(){
          var _this = this;
          //校验
          var checkStatus = true;
          $('input').each(function(){
            if($(this).hasClass('error')){
              checkStatus = false;
              return false;
            }
          })
          if(!checkStatus){
            FW.use('Widget').alert('请正确输入完整信息','danger');
            return;
          }
          //内容添加
          if(_this.MY.action == _this.MY.act.conAdd){
            _this.API.private("privateSubmitConAdd",function(data){
              _this.MY.cid = data[1];
              FW.trigerEvent('triggerSkuSubmit',data[1]);
            });
          }
          //编辑内容
          else if(_this.MY.action == _this.MY.act.conEdit){
            _this.API.private("privateSubmitConEdit",function(){
              FW.trigerEvent('triggerSkuSubmit');
            });
          }
        },
        trigerStep3: function(){
          this.API.private('privateSetNavbar',3);
          $('#skuMgrGadget').hide();
          $('#submitBtn').hide();
          this.API.show('viewGoodsMgrStep3', {action: this.MY.action});
        },
        trigerReset: function(){
          this.API.private('privateStep2');
        },
        trigerAdd: function(){
          this.MY.cid = '';
          this.API.private('privateStep2');
        },
        trigerStep1: function(){
          this.MY.cid = '';
          this.MY.nodeid = '';
          this.API.private('privateStep1');
        },
        trigerGoList: function(){
          var hash = '/page/manager/goods_list.jsp';
          window.location.href = Cfg.baseUrl+ hash;
          top.location.hash = Cfg.baseUrl+ hash;
        }
      }
    }
  );
  return FW;
});

