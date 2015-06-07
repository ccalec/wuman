
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

          // 获取类目属性列表:
          //参数：param1
          var param1 = {
            alias: 'category_properties',
            param:{
              nodeid: _this.MY.cateid,
              tag: 1  //销售属性
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

          // 获取类目属性值列表
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

          //数据map
          var pMap = _this.MY.pMap = {};
          var pvMap = _this.MY.pvMap = {};
          var skuMap = _this.MY.skuMap = {};

          var skuMapData = _this.MY.skuMapData = {
            feaField: 'feature',
            showFields: ['seller_bianma', 'price', 'quantity'],
            headList: [],
            skuList: $.extend([],skuData.cmsdata)
          };

          // 使用abcdefg的字母顺序进行排序
          var s = 'abcdefghijkmnlopqrstuvwxyzABCDEFGHIJKMNLOPQRSTUVWXYZ';
          // 设置pMap
          $.each(pData.cmsdata,function(i,k){
            k['_sn'] = s.charAt(i);  //排序标记
            k['_len'] = 0;  //有值的pv数
            k['_actpv'] = []; //有效pv数组
            pMap[k.cid] = k;
          });
          //设置pvMap, 并放入pMap
          $.each(pvData.cmsdata,function(i,k){
            pvMap[k.cid] = k;
            pMap[k['property_id']]['pvList'] = pMap[k['property_id']]['pvList'] || [];
            k['_sn'] = s.charAt(pMap[k['property_id']]['pvList'].length);  //排序标记
            pMap[k['property_id']]['pvList'].push(k);
          });
          // 设置skuMapData
          $.each(skuData.cmsdata,function(i,k){
            skuMap[k.cid] = k;
          });
          // 标记有值的p-v, 将sku的feature转为pvMap，并将排序标记复制给_sort字段
          $.each(skuData.cmsdata,function(i,sku){
            var feaArr = sku[skuMapData.feaField].split(',');
            sku['_fe'] = {};
            sku._sort = []; //排序标示
            $.each(feaArr,function(ei,pvid){
              if(pvMap[pvid]){
                pvMap[pvid]['activeStatus'] = true;
                var pid = pvMap[pvid]['property_id'];
                if(pMap[pid]){
                  pvMap[pvid]['_initStatus'] = true;
                  pMap[pid]['_len']++;
                  pMap[pid]['_actpv'].push(pvMap[pvid]);
                  sku['_fe'][pid] = pvMap[pvid];
                  sku._sort.push(pMap[pid]['_sn']+pvMap[pvid]['_sn']);
                }
              }
            });
            sku._sort = sku._sort.length ? sku._sort.sort() : ['ZZ','ZZ','ZZ','ZZ'];  //按照p排序
          });

          //主列表数据
          $.each(skuData.cmsdata,function(i, sku){
            $.each(pMap,function(pK,pV){
              if(!pV['_len'].length) return;
              var obj = sku['_fe'][pK] || {cid:'',value:'-'};
            });
          });
        },
        privateShowSkuList: function(){
          var _this = this;

          //列表头th部分
          var headList = [];
          $.each(_this.MY.pMap,function(pK,pV){
            if(!pV['_len']) return;
            headList.push(pV['property_name']);
          });
          $.each(_this.MY.skuMapData.showFields, function(i, field){
            headList.push(_this.MY.skuDescMap[field].title);
          });
          _this.MY.skuMapData.headList = headList;

          //主数据排序
          _this.MY.skuMapData.skuList.sort(function(a,b){
            return a._sort.join('').localeCompare(b._sort.join(''));
          });

          //展现试图
          _this.API.show('viewSkuMgr', {
            cateid: _this.MY.cateid,
            pMap : _this.MY.pMap,
            skuMapData : _this.MY.skuMapData
          });
          console.log(_this.MY.skuMapData.skuList);
        },
        privateBindCheckedPV: function(){
          var _this = this;
          //勾选属性勾选一个选项，重新绘制一次
          $("#skuMgrGadget").delegate("input[name='pvid']","click",function(){
            if($(this).hasClass('disabled')) return false;
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
              if(!pMap[curpid]['_len']){

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
                // 0. 判断当前所属哪个p,将其排除在外
                // 1. 计算增加条数： 除当前p外，p中有效pv数相乘
                // 2. 遍历各个p, 计算当前有值的pv数，用总数除以有效pv值 ＝ 单个显示次数
                // 3. 循环总数，添加初始化数据进入skuList各个feature属性
                var tolLen = 1;
                $.each(pMap,function(pid,pobj){
                  if(curpid==pid || !pobj['_len']) return;
                  tolLen=tolLen*pobj['_len'];
                });
                for (var i = 0; i < tolLen; i++) {  //添加sku数据
                  var skuobj = {};
                  skuobj['_fe'] = {};
                  skuobj['_fe'][curpid] = pvMap[curpvid];
                  skuobj._sort = [cursn];
                  $.each(pMap,function(pid,pobj){
                    if(curpid == pid || !pobj['_len']) return;
                    var len = pobj['_len'];
                    var curCS = tolLen/len;
                    var idx = Math.floor(i/curCS);
                    // sku字段值
                    skuobj['_fe'][pid] = pobj['_actpv'][idx];
                    //排序标示
                    skuobj._sort.push(pobj['_sn']+pobj['_actpv'][idx]['_sn']);
                  });
                  skuobj._sort  = skuobj._sort.sort();  //按照p排序
                  allSkuList.push(skuobj);
                };
              }

              //标记当前点击的pvobj
              pMap[curpid]['_len']++;
              pMap[curpid]['_actpv'].push(pvMap[curpvid]);
              pvMap[curpvid]['activeStatus'] = true;

            }else{ //取消

              //如果在当前p是唯一值，则删除相关数据中的pv
              if(pMap[curpid]['_len']==1){
                //如果是最后一笔sku数据，且只有一个pv
                if(allSkuList.length==1 && allSkuList[0]._sort.length==1){
                  allSkuList = _this.MY.skuMapData.skuList = [];
                }else{
                  $.each(allSkuList,function(i,sku){
                    if(!sku['_fe'][curpid]) return;
                    delete sku['_fe'][curpid];
                    var idx2 = $.inArray(cursn, sku._sort);
                    sku._sort = arrDel(sku._sort,idx2);
                  });
                }
              }else{
                //如果不是当前p唯一值，则删除所有相关的数据
                var skuList = [];
                $.each(allSkuList,function(i,sku){
                  console.log(sku['_fe'][curpid]['cid'] != curpvid);
                  if(sku['_fe'][curpid]['cid'] != curpvid){
                    skuList.push(sku);
                  };
                });
                _this.MY.skuMapData.skuList = allSkuList = skuList;
              };

              //pv有效值减一
              pMap[curpid]['_len']--;
              $.each(pMap[curpid]['_actpv'],function(i, pvobj){
                if(pvobj.cid===curpvid){
                  pMap[curpid]['_actpv'] = arrDel(pMap[curpid]['_actpv'], i);
                  return false;
                }
              });
              pvMap[curpvid]['activeStatus'] = false;
            }
            //获取到最新的allSkuList后，重新渲染试图
            _this.API.private('privateShowSkuList');

            //校验所有tr是否编辑状态
            $('#J_skuform tbody tr').each(function(){
              _this.API.private('privateCheckTrEdit', $(this));
            });

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
                FW.use('Widget').alert('请正确输入商家编码','warning');
                $(self).addClass('error');
                return false;
              }else{
                $(self).removeClass('error');
              }
            }else if(name=='price'){
              if(!/^\d+(\.)?\d+$/.test($.trim($(this).val()))){
                FW.use('Widget').alert('请正确输入商品价格','warning');
                $(self).addClass('error');
                return false;
              }else{
                $(self).removeClass('error');
              }
            }else if(name=='quantity'){
              if(!/^\d+$/.test($.trim($(this).val()))){
                FW.use('Widget').alert('请正确输入库存','warning');
                $(self).addClass('error');
                return false;
              }else{
                $(self).removeClass('error');
              }
            }
            // 单行校验
            var p_tr = $(self).parents('tr');
            _this.API.private('privateCheckTrEdit',p_tr);
          });
        },
        privateCheckTrEdit: function(p_tr){
          var _this = this;
          var curskuid = $.trim(p_tr.find("input[name='cid']").val());
          var editDataMap = _this.MY.editDataMap = _this.MY.editDataMap || {};
          var skuMapData = _this.MY.skuMapData;
          var skuMap = _this.MY.skuMap;
          // 状态变更，判断是否原始数据, 且数据是否与原数据有变动
          var editStatus = false;
          if(curskuid && skuMap[curskuid]){  //存在cid标示是编辑
            //如果feature不一样，则必定是编辑状态
            var obj = {}
            p_tr.find('input').each(function(){
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
            var fea = _this.MY.skuMapData.feaField;
            obj[fea] = obj[fea].sort(function(a,b){return a>b}).join(',');
            //校验feature
            if(obj[fea] != skuMap[curskuid][fea]){
              editDataMap[curskuid] = editDataMap[curskuid] || $.extend({}, skuMap[curskuid]);
              editDataMap[curskuid][fea] = obj[fea];
              editStatus = true;
            }
            //校验自定义字段
            $.each(skuMapData.showFields, function(i,field){
              var propval = obj[field];
              if(propval != skuMap[curskuid][field]){
                editDataMap[curskuid] = editDataMap[curskuid] || $.extend({}, skuMap[curskuid]);
                editDataMap[curskuid][field] = propval;
                editStatus = true;
              }
            });
          }
          if(editStatus){
            p_tr.addClass('tr_edit');
          }else{
            delete editDataMap[curskuid];
            p_tr.removeClass('tr_edit');
          }
        }
      },
      TrigerEvent:{
        triggerShowSkuView: function(cid, cateid){
          var _this = this;
          _this.MY = {}; //清空数据
          _this.MY.cid = cid;
          _this.MY.cateid = cateid;
          _this.API.private('privateShowDefaultView');
        },
        triggerSkuSubmit: function(cid){
          var _this = this;
          if(cid){
            _this.MY.cid = cid;
          }
          var editDataMap = _this.MY.editDataMap = _this.MY.editDataMap || {};
          var addData = [];

          $('#J_skuform').find('tr.tr_add').each(function(){
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

          if(Object.keys(editDataMap)+addData.length){
            FW.trigerEvent('trigerStep3');
            return;
          }
          //多请求同时发送初始化
          var postStatus = true;
          _this.API.initPost();

          //修改部分的参数,
          var param = {
            alias: 'sku',
            param: {}
          };
          // 修改的请求：
          $.each(editDataMap,function(k,v){
            param.param = v;
            _this.API.addPost('modifyContent', 'cms', param, function(code,data){
              if(code!=0 || !data){
                postStatus = false;
              }
            });
          });
          // 添加的请求：
          $.each(addData,function(i,o){
            param.param = o;
            _this.API.addPost('addContent', 'cms', param, function(code,data){
              if(code!=0 || !data){
                postStatus = false;
              }
            });
          });
          _this.API.doPost(function(){
            if(postStatus){
              // FW.use('Widget').alert('保存成功','success');
              FW.trigerEvent('trigerStep3');
            }else{
              FW.use('Widget').alert('数据保存存在异常','danger',5000);
              _this.API.private('privateShowDefaultView');
            }
          });
        }
      }
    }
  );
  return FW;
});

