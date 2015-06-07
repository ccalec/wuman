
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  FW.register(
    {
      param:{
        alias:'orders',
        pagesize: 15
      },
      name:'ordersListGadget',
      onCreate:function(){
        var _this = this;
        _this.API.private('privateShowConList');
      },
      FireEvent:{
      },
      private:{
        privateShowConList: function(){
          var _this = this;

          //获得List的dom
          var formDom = _this.API.find("#formContentList");
          //定义获取param,用于获取总数
          var _param = {
            alias: _this.param.alias,
            param: {},
            spes:{
              orderby:[{
                name:"cid",
                desc:"true"
              }]
            }
          }
          //显示分页列表
          _this.API.private("privateBindFormListPage", formDom, _param);
          // 绑定事件
          _this.API.private("privateBindEvent");
        },
        privateFormatData: function(data){
          var _this = this;
          var statusArr = [{"待付款":1,"待发货":2,"已发货":3,"已收货":4,"申请退款":5,"退款成功":6}];
          $.each(data, function(i,item){
            item.add_time = FW.use('DateTime').format(new Date(parseInt(item.add_time)), 'yyyy-MM-dd hh:mm');
            item.ori_price = FW.use().fmtPrice(item.ori_price);
            item.pay_price = FW.use().fmtPrice(item.pay_price);
            item.descurl = Cfg.baseUrl+'/page/manager/orders_edit.jsp?alias=orders&action=conEdit&cid='+item.cid+'&norole=true';
            item.item_good_img = '<img class="img_file" style="height:60px; width:90px;" src="'+Cfg.baseUrl+'/'+item.item_good_img+'">';
            $.each(statusArr[0],function(name,val){
              if(val==item.status){
                item.status = name;
                return false;
              }
            });
          });
        },
        privateBindEvent: function(){
          var _this = this;
          // 全选/反选
          //======全选操作=======
          this.dom.delegate(".btn-sel-all","click",function(){
            $(this).parents('.itemlist').find("caption input").each(function(){
              // $(this).find("input[type='checkbox']:eq(0)").attr("checked",true);
              if(!$(this).attr("checked")){
                $(this).click();
              }
            });
          });

          //======反选操作=======
          this.dom.delegate(".btn-sel-oppo","click",function(){
            $(this).parents('.itemlist').find("caption input").each(function(){
              $(this).click();
            });
          });

          //======订单处理=======
          this.dom.delegate(".btn-order-do","click",function(){
            FW.use('Widget').prompt('<div class="nodata" style="width:600px; height:100px;">订单审核试图..</div>','订单审核');
          });
        },
        privateBindFormListPage:function(_dom,_param){
          var _this = this;
          //查询总数条件
          _this.API.private('privateSetListParam', _param);
          _param.resultset = 'count';
          //计算list的数据总数
          _this.API.doServer('searchOrdersCount', 'orders', _param, function(code,data){
            if(code==0 && data){
              //储存数据总数
              var dataCount = parseInt(data[0].count) || 0;
              //判断总数是否为0，如果为0则显示空数据视图
              if(!dataCount){
                _this.API.show('viewOrdersList');
                //显示分页
                FW.use().showPagination(_dom.find("#pagination"));
              }else{
                //获取pagesize
                var pageSize = _this.param.pagesize || 20;
                var lsPageNum = _param.alias;
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
                  _this.API.doServer('searchOrders', 'orders',  _param, function(code,data){
                    if(code == 0){
                      // 数据格式处理
                      _this.API.private('privateFormatData', data);
                      //生成列表
                      _this.API.show('viewOrdersList', {orderList: data});
                      //显示分页
                      FW.use().showPagination(_this.API.find("#pagination"),dataCount,pageSize,pageNum,function(prePageNum){
                        reShowConList(prePageNum);
                      });
                    }else{
                      FW.use('Widget').alert('查询失败','warning');
                    }
                  })
                }
                reShowConList(curPageNum);
              }
            }else{
              FW.use('Widget').alert('查询失败','warning');
            }
          })
        },
        privateSetListParam: function(_param){
          var whereSql = [];
          var filterParam = this.MY.param;
          for(var prop in filterParam){
            if(!filterParam[prop]) continue;
            if(prop=='item_title'){
              whereSql.push("and item_title like '%"+filterParam[prop]+"%'");
            }
            if(prop=='orderno'){
              whereSql.push("and orderno = '"+filterParam[prop]+"'");
            }
            if(prop=='buyer_nick'){
              whereSql.push("and buyer_nick like '%"+filterParam[prop]+"%'");
            }
            if(prop=='start_time'){  // UNIX_TIMESTAMP()*1000
              var start_time = FW.use('DateTime').getDayStart(filterParam[prop], 0).getTime();
              whereSql.push("and add_time >= "+start_time);
            }
            if(prop=='end_time'){  // UNIX_TIMESTAMP()*1000
              var end_time = FW.use('DateTime').getDayStart(filterParam[prop], 1).getTime();
              whereSql.push(" and add_time < "+end_time);
            }
            if(prop=='category_id'){
              whereSql.push("and category_id = " + filterParam[prop]);
            }
            if(prop=='status'){  //订单状态
              whereSql.push("and status = "+filterParam[prop]);
            }
          }
          _param.where = whereSql.join(' ');
        }
      },
      TrigerEvent:{
        trigerUpdateConList: function(param){
          this.MY.param = param;
          this.dom.height(this.dom.height());
          this.API.private("privateShowConList");
        }
      }
    }
  );
  return FW;
});

