
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  FW.register(
    {
      name:'totalGadget',
      onCreate: function(){
        var _this = this;
        var Data = {};
        _this.API.initPost();
        var where1 = 'and status = 0';
        //商品总数
        _this.API.addPost('searchGoodsCount', 'goods', {where:where1}, function(code,data){
          if(code==0 && data){
            Data.allGoods = data[0].count;
          }
        });
        //上架宝贝数
        var where2 = 'and status = 0 and start_time < UNIX_TIMESTAMP()*1000 and (UNIX_TIMESTAMP()*1000 < end_time or end_time is null)';
        _this.API.addPost("searchGoodsCount",'goods',{where:where2},function(code,data){
          if(code==0 && data){
            Data.shangGoods = data[0].count;
          }
        });
        //历史总销量
        var where3 = "and status in (2,3,4,5)";
        _this.API.addPost('searchOrdersMoney','orders',{where: where3},function(code,data){
          if(code==0 && data){
            Data.allmoney = data[0].money?data[0].money/100:0;
          }
        });
        //今日销量
        var where4 = "and status in (2,3,4,5) and DateDiff(FROM_UNIXTIME(pay_time/1000, '%Y-%m-%d'), now())=0"
        _this.API.addPost('searchOrdersMoney','orders',{where:where4},function(code,data){
          if(code==0 && data){
            Data.todaymoney = data[0].money?data[0].money/100:0;
          }
        });
        //待付款
        var where5 = 'and status = 1';
        _this.API.addPost('searchOrdersCount','orders',{where:where5},function(code,data){
          if(code==0 && data){
            Data.dfk = data[0].count;
          }
        });
        // 待发货
        var where6 = 'and status = 2';
        _this.API.addPost('searchOrdersCount','orders',{where:where6},function(code,data){
          if(code==0 && data){
            Data.dfh = data[0].count;
          }
        });
        // 已发货
        var where7 = 'and status = 3';
        _this.API.addPost('searchOrdersCount','orders',{where:where7},function(code,data){
          if(code==0 && data){
            Data.yfh = data[0].count;
          }
        });
        //总反馈量
        var where8 = "";
        _this.API.addPost('searchFeedback','feedback',{where:where8},function(code,data){
          if(code==0 && data){
            Data.allFeedback = data[0].count;
          }
        });
        // 今日反馈量
        var where9 = "and DateDiff(FROM_UNIXTIME(add_time/1000, '%Y-%m-%d'), now())=0";
        _this.API.addPost('searchFeedback','feedback',{where:where9},function(code,data){
          if(code==0 && data){
            Data.todayFeedback = data[0].count;
          }
        });
        _this.API.doPost(function(){
          _this.API.show('viewTotalGadget', Data);
        });
      },
      FireEvent:{
      },
      private:{
      },
      TrigerEvent:{
      }
    }
  );
  return FW;
});

