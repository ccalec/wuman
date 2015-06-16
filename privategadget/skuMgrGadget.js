
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  FW.register(
    {
      param:{
        alias:'sku'
      },
      name:'skuMgrGadget',
      onCreate:function(){
        var _this = this;
        //呆梨事件绑定
        _this.API.private('privateBindCheckedPV');
        _this.API.private('privateBindAddPV');
        _this.API.private('privateBindEditSku');
      },
      FireEvent:{

      },
      private:{
        privateShowDefaultView: function(){
          var _this = this;
          _this.API.private('privateGetData', function(){
            _this.API.private('privateFormatData');
            _this.API.private('privateShowSkuList');
          });
        },
        privateGetData: function(callback){
          var _this = this;

          //多请求同时发送初始化
          _this.API.initPost();

          // 获取类目属性列表, 包含销售属性和普通属性
          //参数：param1
          var param1 = {
            alias: 'category_properties',
            param:{
              nodeid: _this.MY.cateid
            },
            spes:{
              orderby:[{
                name: "cid",
                desc: "false"
              }]
            }
          };
          _this.API.addPost('queryContent', 'cms', param1, function(code,data){
            if(code==0&&data){
              _this.MY.pData = data;
            }
          });

          // 获取类目属性值列表, 包含销售属性和普通属性
          //参数：param2
          var param2 = {
            alias: 'category_property_values',
            param:{
              category_id: _this.MY.cateid
            },
            spes:{
              orderby:[{
                name: "cid",
                desc: "false"
              }]
            }
          };
          _this.API.addPost('queryContent', 'cms', param2, function(code,data){
            if(code==0&&data){
              _this.MY.pvData = data;
            }
          });

          // 获取sku列表
          //参数：param3
          var param3 = {
            alias: 'sku',
            param:{
              nodeid: _this.MY.cid,
              status: "0" //有效sku
            },
            spes:{
              orderby:[{
                name: "cid",
                desc: "false"
              }]
            }
          };
          _this.API.addPost('queryContent', 'cms', param3, function(code,data){
            if(code==0&&data){
              _this.MY.skuData = data;
            }
          });

          //发送请求
          _this.API.doPost(function(){
            callback && callback();
          });
        },
        privateFormatData: function(){
          var _this = this;

          var pData = _this.MY.pData;
          var pvData = _this.MY.pvData;
          var skuData = _this.MY.skuData;

          //数据描述map
          var pDescMap = _this.MY.pMap = FW.use().evalJSON(pData.cmsmetadata.dataDesc);
          var pvDescMap = _this.MY.pvDescMap = FW.use().evalJSON(pvData.cmsmetadata.dataDesc);
          var skuDescMap = _this.MY.skuDescMap = FW.use().evalJSON(skuData.cmsmetadata.dataDesc);

          // 数据
          pData.cmsdata = pData.cmsdata || [];
          pvData.cmsdata = pvData.cmsdata || [];
          skuData.cmsdata = skuData.cmsdata || [];

          //sku数据map
          var pMap = _this.MY.pMap = {};
          var pvMap = _this.MY.pvMap = {};
          var skuMap = _this.MY.skuMap = {};

          // 普通属性map
          var ptpMap = _this.MY.ptpMap = {};
          var ptpvMap = _this.MY.ptpvMap = {};

          var skuMapData = _this.MY.skuMapData = {
            feaField: 'feature',
            showFields: ['seller_bianma', 'price', 'quantity'],
            headList: [],
            skuList: $.extend([],skuData.cmsdata)
          };

          // 使用abcdefg的字母顺序进行排序
          var sn = 'abcdefghijkmnlopqrstuvwxyzABCDEFGHIJKMNLOPQRSTUVWXYZ';
          // 设置pMap
          $.each(pData.cmsdata,function(i,pobj){
            //判断是哪种属性
            if(pobj.tag==0){
              pobj['_pvobjs'] = [];  //p下所有pv对象
              ptpMap[pobj.cid] = pobj;
            }else{
              pobj['_sn'] = sn.charAt(i);  //排序标记
              pobj['_actpvids'] = [];  //激活的pvlen
              pobj['_pvids'] = [];  //p下所有pv的ids
              pMap[pobj.cid] = pobj;
            }
          });
          //设置pvMap, 并放入pMap
          $.each(pvData.cmsdata, function(i,pvobj){
            var pid = pvobj['property_id'];
            if(ptpMap[pid]){ // 普通属性
              pvobj['_selected'] = $.inArray(pvobj.cid, _this.MY.feature)!=-1?"selected":"";
              ptpMap[pid]['_pvobjs'].push(pvobj);
            }
            if(pMap[pid]){  //销售属性
              pvMap[pvobj.cid] = pvobj;
              pvobj['_sn'] = sn.charAt(pMap[pid]['_pvids'].length);  //排序标记
              pMap[pid]['_pvids'].push(pvobj.cid);
            }
          });
          // 设置skuMapData
          $.each(skuData.cmsdata,function(i,skuobj){
            skuMap[skuobj.cid] = skuobj;
          });
          // 标记有值的p-v, 将sku的feature转为pvMap，并将排序标记复制给_sort字段
          $.each(skuData.cmsdata, function(i,skuobj){
            var feaArr = skuobj[skuMapData.feaField].split(',');
            skuobj['_fe'] = {};
            skuobj._sort = []; //排序标示
            $.each(feaArr,function(ei, pvid){
              var pvobj = pvMap[pvid];
              if(pvobj){
                pvobj['activeStatus'] = true;
                var pid = pvobj['property_id'];
                var pobj = pMap[pid];
                if(pobj){
                  if($.inArray(pvid, pobj['_actpvids'])==-1){
                    pobj['_actpvids'].push(pvid);
                  }
                  skuobj['_fe'][pid] = pvobj;
                  skuobj._sort.push(pobj['_sn']+pvobj['_sn']);
                }
              }
            });
            skuobj._sort = skuobj._sort.length ? skuobj._sort.sort() : ['ZZ','ZZ','ZZ','ZZ'];  //按照p排序
          });
          // console.log("xxxxxxxxxxx123xxxxx",this.MY);
        },
        privateShowSkuList: function(){
          var _this = this;
          //列表头th部分
          var headList = [];
          $.each(_this.MY.pMap, function(pid,pobj){
            if(!pobj['_actpvids'].length) return;
            headList.push(pobj['property_name']);
          });
          $.each(_this.MY.skuMapData.showFields, function(i, field){
            headList.push(_this.MY.skuDescMap[field].title);
          });
          _this.MY.skuMapData.headList = headList;

          //主数据排序
          _this.MY.skuMapData.skuList.sort(function(a,b){
            return a._sort.join('').localeCompare(b._sort.join(''));
          });

          console.log("===========",_this.MY.ptpMap);
          //展现试图
          _this.API.show('viewSkuMgr', {
            cateid: _this.MY.cateid,
            ptpMap: _this.MY.ptpMap,
            pMap : _this.MY.pMap,
            pvMap : _this.MY.pvMap,
            skuMapData : _this.MY.skuMapData
          });
          // console.log(_this.MY.skuMapData.skuList);
        },
        privateBindCheckedPV: function(){
          var _this = this;
          //勾选属性勾选一个选项，重新绘制一次
          $("#skuMgrGadget").delegate("input[name='pvid']","click",function(){
            // if($(this).hasClass('disabled')) return false;
            var pMap = _this.MY.pMap;
            var pvMap = _this.MY.pvMap;
            var skuMapData = _this.MY.skuMapData;
            var allSkuList = _this.MY.skuMapData.skuList;  //所有sku

            // 获取点击对象所属p,pv
            var curpid =  $(this).data('pid');
            var curpvid = $.trim($(this).val());
            var cursn = pMap[curpid]['_sn']+pvMap[curpvid]['_sn'];

            //选中
            if($(this).attr('checked')){
              // n. 如果是p中第一个点击，则是在之前得sku上添加sort和feature
              if(!pMap[curpid]['_actpvids'].length){
                //如果是第一笔sku数据，且只有一个pv
                if(!allSkuList.length){
                  allSkuList[0] = {};
                  allSkuList[0]._sort = [cursn];
                  allSkuList[0]['_fe'] = {};
                  allSkuList[0]['_fe'][curpid] = pvMap[curpvid];
                }else{
                  $.each(allSkuList, function(i,sku){
                    sku['_fe'][curpid] = pvMap[curpvid];
                    sku._sort.push(cursn);
                    sku._sort.sort();
                  });
                }
              }else{
                // 0. 判断当前所属哪个p,将当前p内置为第一个
                // 1. 递归循环其他p,将其子pv依次与“组合结果数组”进行匹配
                // 2. 遍历组合结果数组，转化成skuobj
                var skuResArr = [{  //组合结果数组
                  '_fe': {},
                  '_sort': []
                }];
                skuResArr[0]['_fe'][curpid] = pvMap[curpvid];
                skuResArr[0]['_sort'].push(pMap[curpid]['_sn']+pvMap[curpvid]['_sn']);
                $.each(pMap,function(pid,pobj){
                  if(curpid==pid || !pobj['_actpvids'].length) return;
                  var newResArr = [];
                  $.each(pobj['_actpvids'], function(i,pvid){
                    $.each(skuResArr,function(ii, skuobj){
                      var newSkuObj = $.extend(true, {}, skuobj);
                      newSkuObj['_fe'][pid] = pvMap[pvid];
                      newSkuObj['_sort'].push(pobj['_sn']+pvMap[pvid]['_sn']);
                      newSkuObj['_sort'] = newSkuObj['_sort'].sort();  //按照p排序
                      newResArr.push(newSkuObj);
                    });
                  });
                  skuResArr = $.extend(true, [], newResArr);
                });
                // console.log("新增的sku:",skuResArr);
                allSkuList = _this.MY.skuMapData.skuList = allSkuList.concat(skuResArr);
              }

              //标记当前点击的pvobj
              pMap[curpid]['_actpvids'].push(curpvid);
              pvMap[curpvid]['activeStatus'] = true;

            }else{ //取消

              //如果在当前p是唯一值，则删除相关数据中的pv
              if(pMap[curpid]['_actpvids'].length==1){
                //如果是最后一笔sku数据，且只有一个pv
                if(allSkuList.length==1 && allSkuList[0]._sort.length==1){
                  allSkuList = _this.MY.skuMapData.skuList = [];
                }else{
                  $.each(allSkuList,function(i,skuobj){
                    if(!skuobj['_fe'][curpid]) return;
                    delete skuobj['_fe'][curpid];
                    var idx2 = $.inArray(cursn, skuobj._sort);
                    skuobj._sort = arrDel(skuobj._sort, idx2);
                  });
                }
              }else{
                //如果不是当前p唯一值，则删除所有相关的数据
                var skuList = [];
                $.each(allSkuList,function(i,sku){
                  // console.log(sku['_fe'][curpid]['cid'] != curpvid);
                  if(sku['_fe'][curpid]['cid'] != curpvid){
                    skuList.push(sku);
                  };
                });
                _this.MY.skuMapData.skuList = allSkuList = skuList;
              };

              //actpvids减
              $.each(pMap[curpid]['_actpvids'],function(i, pvid){
                if(pvid==curpvid){
                  pMap[curpid]['_actpvids'] = arrDel(pMap[curpid]['_actpvids'], i);
                  return false;
                }
              });
              pvMap[curpvid]['activeStatus'] = false;
            }
            //获取到最新的allSkuList后，重新渲染试图
            _this.API.private('privateShowSkuList');

          });
          function arrDel(arr,d){
            return arr.slice(0,d).concat(arr.slice(d+1));
          }
        },
        privateBindAddPV: function(){
          var _this = this;
          //添加pv
          $("#skuMgrGadget").delegate(".J_addPV","click",function(){
            var pid = $(this).data('pid');
            // 弹出添加层
            var domHtml = '<div class="goodaddpv"><label>属性名：<input name="property_name" type="text"></label></div>';
            FW.use('Widget').prompt(domHtml,'添加属性',function(){
              //点击确定
              var value = $.trim($(".goodaddpv input[name='property_name']").val());
              if(!value){
                $(".goodaddpv input[name='property_name']").addClass('error');
                return;
              }
              var _param = {
                category_id: _this.MY.cateid,
                property_id: pid,
                value: value,
                addtime: new Date().getTime()
              };
              var param = {
                alias: 'category_property_values',
                param: _param
              };
              _this.API.doServer('addContent', 'cms', param, function(code,data){
                if(code==0&&data){
                  FW.use('Widget').alert('添加成功','success');
                  setTimeout(function(){
                    _this.API.private('privateShowDefaultView');
                  },1500);
                }
              });
            });
          });
        },
        privateBindEditSku: function(){
          var _this = this;
          //绑定input输入校验, 状态、数据变更
          $("#skuMgrGadget").delegate("input","blur",function(){
            var self = this;
            var name = $(self).attr('name');
            var value = $.trim($(self).val());
            // 校验
            if(name=='seller_bianma'){
              if(!$.trim($(this).val())){
                $(self).addClass('error');
                return false;
              }else{
                $(self).removeClass('error');
              }
            }else if(name=='price'){
              if(!/^\d+(\.)?\d+$/.test($.trim($(this).val()))){
                $(self).addClass('error');
                return false;
              }else{
                $(self).removeClass('error');
              }
            }else if(name=='quantity'){
              if(!/^\d+$/.test($.trim($(this).val()))){
                $(self).addClass('error');
                return false;
              }else{
                $(self).removeClass('error');
              }
            }
          });
        }
      },
      TrigerEvent:{
        triggerShowSkuView: function(cid, cateid, feature){
          var _this = this;
          _this.MY = {}; //清空数据
          _this.MY.cid = cid || 0;
          _this.MY.cateid = cateid;
          _this.MY.feature = feature ? feature.split(',') : [];
          _this.API.private('privateShowDefaultView');
        },
        triggerSkuSubmit: function(cid){
          var _this = this;
          if(cid){
            _this.MY.cid = cid;
          }
          var addData = [];
          $('#J_skuform').find('tbody>tr').each(function(){
            if(!$(this).find('input').length) return true;
            var obj = {
              nodeid: _this.MY.cid,
              addtime: new Date().getTime(),
              status: "0"  //销售属性
            };
            $(this).find('input').each(function(){
              var val = $.trim($(this).val());
              var name = $(this).attr('name');
              var type = $(this).attr('type');
              if(type=="checkbox"){
                obj[name] = obj[name] || [];
                obj[name].push(parseInt(val));
              }else{
                obj[name] = val;
              }
            });
            obj[_this.MY.skuMapData.feaField] = obj[_this.MY.skuMapData.feaField].sort(function(a,b){return a>b}).join(',');
            addData.push(obj);
          });
          if(!addData.length){
            FW.trigerEvent('trigerStep3');
            return;
          }

          //多请求同时发送初始化
          _this.API.initPost();

          //先删除原来的所有sku后添加,
          // 删除的请求：
          $.each(_this.MY.skuMap,function(skuid,skuobj){
            (function(_skuid){
              var param = {
                alias: 'sku',
                param: {
                  cid: _skuid
                }
              };
              _this.API.addPost('deleteContent', 'cms', param, function(code,data){
              });
            })(skuid);
          });

          // 添加的请求：
          $.each(addData,function(i,o){
            (function(obj){
              var param = {
                alias: 'sku',
                param: obj
              };
              _this.API.addPost('addContent', 'cms', param, function(code,data){
              });
            })(o);
          });
          _this.API.doPost(function(){
            FW.trigerEvent('trigerStep3');
          });
        }
      }
    }
  );
  return FW;
});

