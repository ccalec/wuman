/**
* @fileOverview CMS后台内容操作视图的扩展函数Gadget
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name voucherEditGadget
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
        alias: 'voucher'
      },
      name:"voucherEditGadget",
      extends:["cmsMgrGadget"],
      FireEvent:{
      },
      private:{
        privateSetDescAndData: function(_alias,_data,_callback){
          var _this = this;
          var _desc = _this.MY.contentDesc[_alias];

          var actList = [];
          var catList = [];
          var allStatus = false;
          var actStatus = false;
          var actData = [];
          var catidStatus = false;
          var catidData = [];
          var otherStatus = false;

          //判断是否发放开始，显示提示文案
          if(_data.start_time < new Date().getTime()){
            _desc.title.desc = '<span style="color:red">红包发放已经开始，禁止任何修改</span>';
          }
          //处理使用范围
          if(_data.use_range){
            var o_use_range = _data.use_range.split(';');
            $.each(o_use_range,function(i,sn){
              sn = sn.split(":");
              if(sn[0]==='all'){
                allStatus = true;
              }
              if(sn[0]==='other'){
                otherStatus = true;
              }
              if(sn[0]==='act'){
                actStatus = true;
                actData = sn[1].split(',');
              }
              if(sn[0]==='catid'){
                catidStatus = true;
                catidData = sn[1].split(',');
              }
            });
          }

          //获取actList
          _this.API.private('privateContentDesc','activities',function(desc){
            if(desc){
              var actdesc = (FW.use().evalJSON(desc.dataDesc)).activity_type.valueRange[0];
              $.each(actdesc,function(act_name,val){
                actList.push('<input type="checkbox" value="'+val+'" '+($.inArray(val.toString(),actData)!=-1?'checked="true"':'')+((allStatus || !actStatus)?' disabled="true"':'')+'><span class="lbl"></span> <span class="txt">'+act_name+'</span>');
              });
            }
            //获取顶级类目
            var param = {
              alias: 'category',
              param: {
                nodeid: 0
              }
            };
            _this.API.doServer('queryContent', 'cms', param, function(code, data){
              if(!code&&data){
                $.each(data.cmsdata,function(i,item){
                  catList.push('<input type="checkbox" value="'+item.cid+'" '+($.inArray(item.cid.toString(),catidData)!=-1?'checked="true"':'')+((allStatus || !catidStatus)?' disabled="true"':'')+'><span class="lbl"></span> <span class="txt">'+item.cat_name+'</span>');
                });
              }
              var allIpt = '<input type="checkbox" class="J_all" value="all" '+(allStatus?'checked="true"':'')+'><span class="lbl"></span> <span class="txt">全部可用</span>';
              var actIpt = '<input type="checkbox" class="J_act_all" '+(actStatus?' checked="true"':'')+(allStatus?' disabled="true"':'')+'><span class="lbl"></span>';
              var catidIpt = '<input type="checkbox" class="J_catid_all" '+(catidStatus?' checked="true"':'')+(allStatus?' disabled="true"':'')+'><span class="lbl"></span>';
              var otherIpt = '<input type="checkbox" class="J_other" value="other" '+(otherStatus?' checked="true"':'')+(allStatus?' disabled="true"':'')+'><span class="lbl"></span> <span class="txt">正价商品</span>';
              _desc.use_range.desc = _this.API.getHtml('viewUseRange', {
                actList: actList,
                catList: catList,
                allIpt: allIpt,
                actIpt: actIpt,
                catidIpt: catidIpt,
                otherIpt: otherIpt
              });
              _callback && _callback();
            })
          });
        },
        privateMessConAddOk:function(){
          this.API.private('privateBindEvent');
        },
        privateMessConEditOk:function(data){
          var _this = this;
          var type = data.activity_type;
          //永远禁止
          $('input[name="data.rule_type"],input[name="data.add_time"],input[name="data.total_send_num"],input[name="data.money1_send_num"],input[name="data.money2_send_num"],input[name="data.money3_send_num"]').attr('disabled','true');
          //如果活动开始，禁止修改其他字段
          if(data.start_time < new Date().getTime()){
            var formDom = _this.API.find("#"+_this.param.formConEdit);
            formDom.find('input,select,textarea').each(function(){
              $(this).attr('disabled','true');
            });
            $('.date-time-picker .add-on').remove();
            $('#submitBtn>a:eq(0)').remove();
          }
          //如果是规则三，显示规则价格
          if(data.rule_type==3) _this.API.find('.f_rule_money').show();
          _this.API.private('privateBindEvent');
        },
        privateBindEvent: function(){
          var _this = this;
          //选择规则三，显示规定价格
          if(_this.API.find("input[name='data.rule_type']").val()==3){
            _this.API.find('.f_rule_money').show();
          }
          _this.API.find("input[name='data.rule_type']").change(function(){
            var curval = $(this).val();
            if(curval==3){
              _this.API.find('.f_rule_money').show();
            }else{
              _this.API.find('.f_rule_money').hide();
            }
          });
          // 红包总金额，总个数计算
          _this.API.find("._money1_inp,._money1_num_inp,._money2_inp,._money2_num_inp,._money3_inp,._money3_num_inp").on('blur',function(){
            _this.API.private('privateUpdateTotal');
          });
          // 绑定 use_range勾选
          _this.API.find("#userRageForm input[type='checkbox']").on('click',function(){
            var use_range = [];
            //全选
            if($(this).hasClass('J_all')){
              if($(this).attr('checked')){
                _this.API.find("#userRageForm input[type='checkbox']").not($(this)).attr('disabled','true');
              }else{
                _this.API.find(".J_act_all,.J_catid_all,.J_other").removeAttr('disabled');
              }
            }
            //活动和类目
            if($(this).hasClass('J_act_all') || $(this).hasClass('J_catid_all')){
              if($(this).attr('checked')){
                $(this).parents('li').find("input[type='checkbox']").removeAttr('disabled');
              }else{
                $(this).parents('li').find("input[type='checkbox']").not($(this)).attr('disabled','true');
              }
            }
            //遍历li
            _this.API.find('#userRageForm li').each(function(){
              var curpre = $(this).attr('data-pre');
              var valarr = [];
              $(this).find('input[type="checkbox"]').each(function(){
                var curval = $(this).val();
                if($(this).attr('checked') && !$(this).attr('disabled') && curval && curval!='on'){
                  valarr.push(curval);
                }
              });
              if(valarr.length){
                if(curpre=='all' || curpre=='other'){
                  use_range.push(curpre+';');
                }else{
                  use_range.push(curpre+':'+valarr.join(',')+';');
                }
              }
            })
            //更新
            _this.API.find('input[name="data.use_range"]').val(use_range.join(''));
          });
        },
        privateUpdateTotal: function(){
          var _this = this;
          //获取表单值；
          var m1 = parseInt(_this.API.find("._money1_inp").val()) || 0;
          _this.API.find("._money1_inp").val(m1);
          var m2 = parseInt(_this.API.find("._money2_inp").val()) || 0;
          _this.API.find("._money2_inp").val(m2);
          var m3 = parseInt(_this.API.find("._money3_inp").val()) || 0;
          _this.API.find("._money3_inp").val(m3);
          var n1 = parseInt(_this.API.find("._money1_num_inp").val()) || 0;
          _this.API.find("._money1_num_inp").val(n1);
          var n2 = parseInt(_this.API.find("._money2_num_inp").val()) || 0;
          _this.API.find("._money2_num_inp").val(n2);
          var n3 = parseInt(_this.API.find("._money3_num_inp").val()) || 0;
          _this.API.find("._money3_num_inp").val(n3);
          //计算
          _this.API.find("._total_num_inp").val(n1+n2+n3);
          _this.API.find("._total_money_inp").val(n1*m1+n2*m2+n3*m3);
        }
      },
      TrigerEvent:{
        trigerSubmit: function(){
          var _this = this;
          //编辑
          if(_this.MY.action == _this.MY.act.conEdit){
            _this.API.private("privateSubmitConEdit",function(){
              var hash = '/page/manager/voucher_list.jsp';
              location.href = Cfg.baseUrl+hash;
              top.location.hash = Cfg.baseUrl+hash;
            });
          }
          // 新增
          if(_this.MY.action == _this.MY.act.conAdd){
            _this.API.private("privateSubmitConAdd",function(data){
              var hash = '/page/manager/voucher_list.jsp';
              location.href = Cfg.baseUrl+hash;
              top.location.hash = Cfg.baseUrl+hash;
            });
          }
        },
        trigerGoBack: function(){
          var hash = '/page/manager/voucher_list.jsp';
          location.href = Cfg.baseUrl+hash;
          top.location.hash = Cfg.baseUrl+hash;
        }
      }
    }
  );
  return FW;
});

