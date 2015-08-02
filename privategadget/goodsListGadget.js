
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  require("../gadget/cmsMgrGadget");
  FW.register(
    {
      param:{
        alias:'goods',
        pagesize: 10
      },
      name:'goodsListGadget',
      extends:["cmsMgrGadget"],
      FireEvent:{
        updateStatus: function(type){
          var _this = this;
          // 校验是否选中商品
          _this.MY.maskData = _this.API.private('privateGetCheckedData');
          if(!_this.MY.maskData.length){
            FW.use('Widget').alert('请先勾选商品！');
            return;
          }
          _this.MY.maskType = type;
          _this.MY.maskTitle = type==0?"上架":"下架";
          var htmlstr = _this.API.getHtml('viewUpdateStatus',{title: _this.MY.maskTitle});
          FW.use('Widget').prompt(htmlstr, _this.MY.maskTitle, function(){
            _this.API.private('privateSubmitUpdateStatus');
          },true);
          FW.use("Widget").bindDateTimeP($('.yushe-time'));
        },
        updateYxsx: function(){
          var _this = this;
          // 校验是否选中商品
          _this.MY.maskData = _this.API.private('privateGetCheckedData');
          if(!_this.MY.maskData.length){
            FW.use('Widget').alert('请先勾选商品！');
            return;
          }
          var htmlstr = _this.API.getHtml('viewUpdateYxsx');
          FW.use('Widget').prompt(htmlstr, '设置优先上新', function(){
            _this.API.private('privateSubmitUpdateYxsx');
          },true);
          FW.use("Widget").bindDateTimeP($('.yushe-time'));
        },
      },
      TrigerEvent:{
        trigerUpdateConList: function(param){
          this.MY.param = param;
          this.dom.height(this.dom.height());
          this.API.private("privateShowConList");
        }
      },
      private:{
        privateShowDefaultView: function(){
          var _this = this;
          _this.API.private("privateShowConList");
        },
        privateBtnConEdit: function(_dom,_data){
          var hash = '/page/manager/goods_mgr.jsp?nodeid='+_data.nodeid+'&cid='+_data.cid+'&action=conEdit';
          window.location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        },
        privateGetCheckedData: function(){
          var _this = this;
          //获得选中的商品ids
          var formDom = _this.API.find("#"+_this.param.formConList);
          var arrCheckData = formDom[0].batchEdit();
          return arrCheckData || [];
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
            if(prop=='status'){  //默认上下架时间都为空
              if(filterParam[prop]==1){ //预设上架
                whereSql.push("and start_time > UNIX_TIMESTAMP()*1000 and (UNIX_TIMESTAMP()*1000 < end_time)");
              }else if(filterParam[prop]==2){ //已经上架
                whereSql.push("and start_time < UNIX_TIMESTAMP()*1000 and (UNIX_TIMESTAMP()*1000 < end_time)");
              }else if(filterParam[prop]==3){ //预设下架
                whereSql.push("and UNIX_TIMESTAMP()*1000 < end_time");
              }else if(filterParam[prop]==4){ //已下架
                whereSql.push("and end_time < UNIX_TIMESTAMP()*1000 and start_time != end_time");
              }else if(filterParam[prop]==5){ //从未上架
                whereSql.push("and start_time = end_time");
              }else if(filterParam[prop]==6){ //新品优先
                whereSql.push("and cid in (select item_id from (select item_id from wm_new_item where start_time < UNIX_TIMESTAMP()*1000 and UNIX_TIMESTAMP()*1000 < end_time order by cid desc limit 1000) a)");
              }
            }
          }
          _param.where = whereSql.join(' ');
        },
        privateBtnConDel: function(_dom,_data){
          var _this = this;
          //判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
          var curAlias = _this.MY.sonAlias || _this.MY.alias;
          if(confirm("确认要删除该内容吗？")){
            var _param = {
              alias:curAlias,
              param:{
                cid:_data.cid,
                status: '1'
              }
            }
            var _serverName = _this.MY.serverName.mCon;
            _this.API.doServer(_serverName,_this.MY.package,_param,function(code,data){
              if(code == 0){
                _this.API.private("privateShowConList");
              }else{
                FW.use('Widget').alert("内容删除失败！");
              }
            });
          }
        },
        privateBtnConPLDel: function(){
          var _this = this;
          //获得dom
          var formDom = _this.API.find("#"+_this.param.formConList);
          //判断当前视图是否存在_this.MY.sonAlias，如果存在则为内容子alias操作
          var curAlias = _this.MY.sonAlias || _this.MY.alias;
          if(confirm("确认要删除该内容吗？")){
            //单个循环删除=======
            //多请求同时发送初始化
            _this.API.initPost();
            var arrCheckData = formDom[0].batchEdit();
            for (var i = 0; i < arrCheckData.length; i++) {
                _this.API.addPost(_this.MY.serverName.mCon,_this.MY.package,{alias:curAlias,param:{cid:arrCheckData[i].cid, status: '1'}},function(code,data){
                  if(code!==0){
                    FW.use('Widget').alert("删除失败！");
                  }
                });
            }
            _this.API.doPost(function(){
              _this.API.private("privateShowConList");
            })
          }
        },
        privateSubmitUpdateYxsx: function(){
          var _this = this;

          var start_time = FW.use('DateTime').format4($('.J_yxsx_start').val(), $('.J_yxsx_start').attr('data-format')).getTime();
          var end_time = FW.use('DateTime').format4($('.J_yxsx_end').val(), $('.J_yxsx_end').attr('data-format')).getTime();

          //单个循环删除=======
          //多请求同时发送初始化
          _this.API.initPost();

          for (var i = 0; i < _this.MY.maskData.length; i++) {
            var onedata = _this.MY.maskData[i];
            (function(_onedata){
              _this.API.addPost('deleteContent','cms',{alias:'new_item',param:{item_id: _onedata.cid}},function(code,data){
                if(code!==0){
                  FW.use('Widget').alert("删除失败！");
                }
              });
              _this.API.addPost('addContent','cms',{alias:'new_item',param:{
                item_id: _onedata.cid,
                start_time: start_time.toString(),
                end_time: end_time.toString()
              }},function(code,data){
                if(code!==0){
                  FW.use('Widget').alert('设置失败','danger');
                }
              });
            })(onedata);
          }
          _this.API.doPost(function(){
            FW.use('Widget').alert('设置成功','success');
            _this.API.private("privateShowConList");
          });
        },
        privateSubmitUpdateStatus: function(){
          var _this = this;
          //获取时间值
          var type = $(".J_timeType:checked").val();
          var ystext = "";
          if(type==0){
            var timeValue = 'UNIX_TIMESTAMP()*1000';
            var timeStamp = FW.use().getServiceTime();
          }else{
            ystext = "预设";
            var ysvalue = $('.J_ysvalue').val();
            var format = $('.J_ysvalue').attr('data-format');
            if(!ysvalue){
              $('.J_ysvalue').addClass('error');
              return;
            }
            var timeValue = "UNIX_TIMESTAMP('"+ysvalue+"')*1000";
            var timeStamp = FW.use('DateTime').format4(ysvalue, format);
          }
          //单个循环删除=======
          //多请求同时发送初始化
          _this.API.initPost();
          var errArr = [];
          for (var i = 0; i < _this.MY.maskData.length; i++) {
            var onedata = _this.MY.maskData[i];
            (function(_onedata){
              //设置时间
              // 如果是上架或预设上架，看下架时间是否大于预设时间  否则 清除下架时间
              // 如果是下架或预设下架，不需要变动上架时间
              if(_this.MY.maskType==0){ //上架
                var start_time = timeValue;
                if(type==0){ //立即上架
                  if(parseInt(_onedata.end_time) < new Date().getTime()){
                    var end_time = ((FW.use('DateTime').dateAdd(new Date(), 365)).getTime()).toString();
                  }
                }else{ //预设上架
                  if(parseInt(_onedata.end_time) > timeStamp){
                    var end_time = 'end_time';
                  }else{
                    FW.use('Widget').alert('商品ID:['+_onedata.cid+']，上架时间必须小于下架时间！', 'danger', 5000);
                    return;
                  }
                }
              }else{
                var start_time = 'start_time';
                var end_time = timeValue;
                if(type==1){
                  if(parseInt(_onedata.start_time) < timeStamp){
                    var start_time = 'start_time';
                  }else{
                    FW.use('Widget').alert('商品ID:['+_onedata.cid+']，下架时间必须大于上架时间！', 'danger', 5000);
                    return;
                  }
                }
              }
              //设置请求参数
              var param = {
                start_time: start_time,
                end_time: end_time,
                cid: _onedata.cid
              };
              _this.API.addPost('updateGoodsTime', 'goods', param, function(code,data){
                if(code!==0){
                  errArr.push(_onedata.cid);
                }
              });
            })(onedata);
          };
          _this.API.doPost(function(){
            if(errArr.length){
              $('#J_conWrap').html('<div class="tac">'+ystext+_this.MY.maskTitle+'失败如下：'+errArr.join(',')+'</div>');
            }else{
              $('#J_conWrap').html('<div class="tac">'+ystext+_this.MY.maskTitle+'成功！');
            }
            setTimeout(function(){
              _this.API.unmask();
              _this.API.private("privateShowConList");
            },2000);
          });
        },
        privateSetDescAndData: function(_alias,_data,_callback){
          var _this = this;
          var _desc = _this.MY.contentDesc[_alias];
          //多请求同时发送初始化
          _this.API.initPost();
          if(_data && _data.length){
            $.each(_data,function(i,k){
              //判断是否是 优先上新
              if(_this.MY.param && _this.MY.param.status==6){
                _this.API.addPost('searchYxsxByCid', 'goods', {item_id: k.cid}, function(code,data){
                  if(code==0&&data){
                    _desc.sn = {
                      type: 'Text',
                      title: '上新时间',
                      islist: '1'
                    };
                    k.sn = FW.use('DateTime').format(new Date(parseInt(data[0].start_time)),'yyyy-MM-dd hh:ss')+
                          " 至 "+
                          FW.use('DateTime').format(new Date(parseInt(data[0].end_time)),'yyyy-MM-dd hh:ss');
                  }
                });
              }
              _this.API.addPost('searchCategoryByCid', 'goods', {cid: k.nodeid}, function(code,data){
                if(code==0&&data){
                  _desc.nodeid.type = 'Hidden';
                  _desc.category = {
                    title: '所属类目',
                    type: 'Text',
                    islist: 1
                  };
                  k.category = data[0].root_catname+" - "+data[0].parent_catname;
                }
              });
            })
            _this.API.doPost(function(){
              if(!_this.MY.param || _this.MY.param.status!=6){
                delete _desc.sn;
              }
              _callback && _callback();
            });
          }else{
            if(!_this.MY.param || _this.MY.param.status!=6){
              delete _desc.sn;
            }
            _callback && _callback();
          }

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
                if(curPageNum<=0) curPageNum = 1;
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

