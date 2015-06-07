
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  require("../breeze/framework/js/tools/Widget")(FW);
  FW.register(
    {
      param:{
        alias:'goods'
      },
      name:'filterGadget',
      onCreate:function(){
        var _this = this;
        // 设置过滤参数对象
        _this.MY.filterData = {};
        //显示默认视图
        _this.API.show('viewFilter');

        //获取一级类目数据
        _this.API.private('privateGetCateList', 0, function(cateList){
          //将数据放入select
          _this.API.append('viewCateListTPL', {cateList: cateList}, '#parentCateList', false);
          //绑定按钮事件
          _this.API.private('privateBindEvent');
        });
      },
      FireEvent:{
      },
      private:{
        privateBindEvent: function(){
          var _this = this;
          //绑定时间控件
          FW.use("Widget").bindDateP($('.J_rksj'));
          // 类目切换事件, 父类目
          _this.API.find('#parentCateList').on('change',function(){
            var parentID = $(this).val();
            _this.API.private('privateGetCateList', parentID, function(cateList){
              if(cateList && cateList.length){
                _this.API.find('.J_nodeid').val(cateList[0].cid);
                _this.API.show('viewCateListTPL', {cateList: cateList}, 'sonCateList', false);
              }else{
                _this.API.find('.J_nodeid').val('');
                _this.API.show('viewCateListTPL', {cateList: []}, 'sonCateList', false);
              }
            });
          });
          // 子类目
          _this.API.find('#sonCateList').on('change',function(){
            var nodeid = $(this).val();
            _this.API.find('.J_nodeid').val(nodeid);
          });
          //搜索按钮
          _this.API.find('.J_submitBtn').on('click',function(){
            _this.API.private('privateGetFilterParam');
            FW.trigerEvent('trigerUpdateConList', _this.MY.filterData);
          });
          //状态tablist 点击事件
          _this.API.find('#J_tablist li').on('click',function(e){
            $(this).addClass('active').siblings().removeClass('active');
            _this.MY.filterData['status'] = $(this).attr('data-value');
            FW.trigerEvent('trigerUpdateConList', _this.MY.filterData);
          });
          // form的提交
          _this.API.find('#J_filterForm').on('submit',function(){
            _this.API.find('.J_submitBtn').trigger('click');
            return false;
          })
        },
        privateGetFilterParam: function(){
          var _this = this;
          var data = _this.API.find('#J_filterForm').serializeArray();
          $.each(data,function(i,k){
            _this.MY.filterData[k.name] = k.value;
          });
        },
        privateGetCateList: function(nodeid, callback){  //获取类目数据
          var _this = this;
          // 获取一级类目
          var param = {
            alias: _this.param.alias,
            param: {
              nodeid: nodeid
            },
            spes:{
              orderby:[{
                name: "cid",
                desc: "false"
              }]
            }
          };
          _this.API.doServer("queryNode", "cms", param, function(code,data){
            if(code!==0 || !data){
              FW.use('Widget').alert('类目查询失败！','danger');
              return;
            }
            callback && callback(data.cmsdata || []);
          });
        }
      },
      TrigerEvent:{
      }
    }
  );
  return FW;
});

