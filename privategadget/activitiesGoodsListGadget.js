
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  require("../gadget/cmsMgrGadget");
  FW.register(
    {
      param:{
        alias:'goods',
        pagesize: 10,
        btnForList:{
          goods:[]
        }
      },
      name:'activitiesGoodsListGadget',
      extends:["cmsMgrGadget"],
      FireEvent:{
      },
      TrigerEvent:{
        trigerUpdateConList: function(param){
          this.MY.param = param;
          this.dom.height(this.dom.height());
          this.API.private("privateShowConList");
        },
        trigerShowAct: function(type, nodeid){
          var _this = this;
          _this.MY.type = type;
          if(type==='MGR'){
            $('#myTab li:eq(0)').addClass('active');
            $('#myTab li:eq(1)').removeClass('active');
          }else{
            $('#myTab li:eq(0)').removeClass('active');
            $('#myTab li:eq(1)').addClass('active');
          }
          // 查询关联的ids
          if(type==='MGR' && nodeid){
            var _param = {
              alias: 'activity_items',
              param: {
                nodeid: nodeid
              }
            };
            _this.MY.ids.cur = [];
            _this.API.doServer('queryContent', 'cms', _param, function(code,data){
              if(code==0&&data.cmsdata){
                $.each(data.cmsdata,function(i,v){
                  _this.MY.ids.cur.push(parseInt(v.item_id));
                });
              }
              _this.API.private("privateShowConList");
              $('#myTab li:eq(0)>a>b').text(_this.MY.ids.cur.length);
            })
          }else{
            _this.API.private("privateShowConList");
          }
        },
        trigerCheckBoxClick:function(rowData,checkStatus){
          var _this = this;
          var ids =  _this.MY.type=='MGR' ? _this.MY.ids.del : _this.MY.ids.add;
          var absStatus = _this.MY.type=='MGR' ? checkStatus : !checkStatus;
          if(absStatus){
            $.each(ids,function(i,itemid){
              if(itemid==rowData.cid){
                ids = arr_del(ids,i);
                return false;
              }
            });
          }else{
            if($.inArray(parseInt(rowData.cid), ids) == -1) ids.push(parseInt(rowData.cid));
          }
          $('#myTab li:eq(1)>a>b').text(_this.MY.ids.add.length);
          $('#searchForList').html('已选宝贝：'+_this.MY.ids.cur.length+'，取消：'+_this.MY.ids.del.length+'，添加：'+_this.MY.ids.add.length);
          FW.trigerEvent('trigerActGoodsRes', _this.MY.ids);
          function arr_del(arr,d){
            return arr.slice(0,d).concat(arr.slice(d+1));
          }
        },
        trigerSubmit: function(){

        },
        trigerGoBack: function(){

        }
      },
      private:{
        privateShowDefaultView: function(){
          var _this = this;
          // 根据当前屏幕设置pagesize
          var winH = $(window).height();
          _this.param.pagesize = Math.floor((winH-300)/46);

          _this.MY.ids = {
            del: [],
            add: [],
            cur: []
          };
        },
        privateMessConListOk:function(_data){
          var _this = this;
          $.each(_data, function(i,item){
            if(($.inArray(parseInt(item.cid), _this.MY.ids.cur)!=-1 || $.inArray(parseInt(item.cid), _this.MY.ids.add)!=-1) && $.inArray(parseInt(item.cid), _this.MY.ids.del)==-1){
              var tr = _this.dom.find('._formlist_cid_inp[value="'+item.cid+'"]').parents('tr')[0];
              $(tr).find('>td input').click();
            }
          });
          $('#searchForList').html('已选宝贝：'+_this.MY.ids.cur.length+'，取消：'+_this.MY.ids.del.length+'，添加：'+_this.MY.ids.add.length);
          _this.dom.find('table').next().css('width',120).find('.btn-del').remove();
        },
        privateSetListParam: function(_param){
          var whereSql = ['and status = 0'];
          var filterParam = this.MY.param;
          for(var prop in filterParam){
            if(!filterParam[prop]) continue;
            if(prop=='title'){
              whereSql.push("and title like '%"+filterParam[prop]+"%'");
            }
            if(prop=='goodsno'){
              whereSql.push("and goodsno like '%"+filterParam[prop]+"%'");
            }
            if(prop=='addtime'){  // UNIX_TIMESTAMP()*1000
              var addtime_start = FW.use('DateTime').getDayStart(filterParam[prop], 0).getTime();
              var addtime_end = FW.use('DateTime').getDayStart(filterParam[prop], 1).getTime();
              whereSql.push("and addtime >= "+addtime_start+" and addtime < "+ addtime_end);
            }
            if(prop=='price_start'){
              whereSql.push("and price*100 >= "+ filterParam[prop]);
            }
            if(prop=='price_end'){
              whereSql.push("and price*100 <= "+ filterParam[prop]);
            }
            if(prop=='nodeid'){
              whereSql.push("and nodeid = "+ filterParam[prop]);
            }
            //已经上架
            // whereSql.push("and start_time < UNIX_TIMESTAMP()*1000 and (UNIX_TIMESTAMP()*1000 < end_time or end_time is null)");
          }
          //根据type判断
          if(this.MY.type=='MGR'){
            if(!this.MY.ids.cur.length){
              whereSql.push("and 1=0");
            }else{
              whereSql.push("and cid in ("+ this.MY.ids.cur.join(',')+")");
            }
          }else{
            if(this.MY.ids.cur.length){
              whereSql.push("and cid not in ("+ this.MY.ids.cur.join(',')+")");
            }
          }
          _param.where = whereSql.join(' ');
        },
        privateBindFormListPage: function(_dom,_param,_type,_callback){
          var _this = this;
          //生成列表前param的参数对外自定义接口
          _this.API.private("privateSetListParam",_param);
          //查询总数条件
          _param.resultset = 'count';
          //计算list的数据总数
          _this.API.doServer('searchGoodsCount', 'goods', _param, function(code,data){
            if(code==0 && data){
              //储存数据总数
              var dataCount = parseInt(data[0].count) || 0;
              //判断总数是否为0，如果为0则显示空数据视图
              if(!dataCount){
                //表单生成前，对数据描述的自定义接口
                _this.API.private("privateSetDescAndData", _param.alias, null, function(){
                  FW.use().createFormList(_this.MY.contentDesc[_param.alias],_dom,null,function(fieldName,fieldValue){
                    _this.API.private("privateOutLinkCB",_this.MY.contentDesc[_param.alias], _dom, fieldName, fieldValue);
                  },_type)
                  //显示分页
                  FW.use().showPagination(_dom.find("#pagination"));
                })
              }else{
                //获取pagesize
                var pageSize = _this.param.pagesize || 20;
                var lsPageNum = _param.param.nodeid ? (_param.alias + _param.param.nodeid) : _param.alias;
                var curPageNum = parseInt(FW.use().load(lsPageNum)) || 1;
                if(curPageNum > Math.ceil(dataCount/pageSize)){
                  curPageNum = Math.ceil(dataCount/pageSize);
                }
                function reShowConList(_prePageNum){
                  //存入本地存储
                  FW.use().save(lsPageNum,_prePageNum);
                  var pageNum = parseInt(_prePageNum);
                  //将_param参数修改为获取最新newData数据的param
                  _param.resultset = 'list';
                  _param.spes.limit = {
                    start: (pageSize*pageNum-pageSize).toString(),
                    length: pageSize.toString()
                  }
                  _this.API.doServer('searchGoods', 'goods', _param, function(code,data){
                    if(code == 0){
                      //表单生成前，对数据库数据类型转换
                      _this.API.private("privateDataToForm", _this.MY.contentDesc[_param.alias], data);
                      //重新显示列表数据
                      function reShowOutLink(_data){
                        //表单生成前，对数据描述和数据的自定义接口
                        _this.API.private("privateSetDescAndData", _param.alias, _data, function(){
                          //生成列表
                          FW.use().createFormList(_this.MY.contentDesc[_param.alias], _dom, _data, function(fieldName,fieldValue){
                            _this.API.private("privateOutLinkCB",_this.MY.contentDesc[_param.alias], _dom, fieldName, fieldValue,function(newdata){
                              reShowOutLink(newdata);
                            })
                          },_type)
                          //显示分页
                          FW.use().showPagination(_dom.find("#pagination"),dataCount,pageSize,pageNum,function(prePageNum){
                            reShowConList(prePageNum);
                          })
                          //执行内容列表回调函数
                          _callback && _callback(data);
                        })
                      }
                      reShowOutLink(data);
                    }
                  })
                }
                reShowConList(curPageNum);
              }
            }
          })
        }
      }
    }
  );
  return FW;
});

