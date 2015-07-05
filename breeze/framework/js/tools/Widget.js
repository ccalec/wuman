/**
* @fileOverview FW配套使用的UI控件API
* @author <a href="http://">Alec</a>
* @version 0.1
*/

/**
* @namespace
* @author Alec
* @name Widget
* @description  FW的核心基本扩展
*/
define(function(require, exports, module) {

  var DateTime = require("./DateTime");

  //用函数自身做域名承载对象
  //这样在外部使用的时候，可以简化比如use("xx/x/xx")(FW);
  var _result = function(fw){
    fw.use(_result);
  }

  _result.getDomain = function(){
    return "Widget";
  }

  /**
   * @function
   * @memberOf Widget
   * @name bindDateTimeP
   * @description 日期＋时间
   * @param {dom} dom input所在的父元素
   */
  _result.alert = function(text,type,timeout){
    type = type || 'info';
    timeout = timeout || 1200;

    var icon = color = '';
    if(type=='success'){
      icon = '<i class="icon-ok bigger-120"></i> ';
      color = 'green';
    }else if(type=='warning'){
      icon = '<i class="icon-warning-sign bigger-120"></i> ';
      color = 'orange';
    }else if(type=='danger'){
      icon = '<i class="icon-remove bigger-120"></i> ';
      color = 'red';
    }else{
      icon = '<i class="icon-info-sign bigger-120"></i> ';
      color = '#2a91d8';
    }
    var htmlArr = [];
    htmlArr.push('<div class="widget-box zdy-alert">');
      htmlArr.push('<div class="widget-header">');
        htmlArr.push('<h5 style="color:gray">系统提示</h5>');
        htmlArr.push('<span class="widget-toolbar">');
          htmlArr.push('<a href="javascript:void(0);" onclick="$.unblockUI();">');
            htmlArr.push('<i class="icon-remove" style="color:gray"></i>');
          htmlArr.push('</a>');
        htmlArr.push('</span>');
      htmlArr.push('</div>');
      htmlArr.push('<div class="widget-body">');
        htmlArr.push('<div class="widget-main" style="padding:30px 20px; font-size: 16px; vertical-align: middle; color:'+color+'">'+icon+text+'</div>');
      htmlArr.push('</div>');
    htmlArr.push('</div>');

    $.blockUI({
      message: htmlArr.join('\n'),
      overlayCSS: {
        backgroundColor: "rgba(0,0,0,.8)"
      },
      css: {
        width: 400,
        height: 124,
        left: ($(window).width() - 400) / 2,
        top: ($(window).height() - 124) / 2,
        border: 'none',
        background: "transparent"
      }
    });
    setTimeout($.unblockUI, timeout);
  };

  /**
   * @function
   * @memberOf Widget
   * @name 弹出dialorg
   * @description 对话框
   * @param {dom} dom钩子或者html
   */
  _result.prompt = function(dom,title,succCallback,errCallback){
    var htmlArr = [];
    htmlArr.push('<div class="widget-box zdy-prompt pull-left" id="promptBox">');
      htmlArr.push('<div class="widget-header">');
        htmlArr.push('<h5 style="color:gray">'+title+'</h5>');
        htmlArr.push('<span class="widget-toolbar">');
          htmlArr.push('<a href="javascript:void(0);" class="propCancel">');
            htmlArr.push('<i class="icon-remove" style="color:gray"></i>');
          htmlArr.push('</a>');
        htmlArr.push('</span>');
      htmlArr.push('</div>');
      htmlArr.push('<div class="widget-body">');
        htmlArr.push('<div class="widget-main no-padding">');
          htmlArr.push('<div id="promptCon"></div>');
          if(succCallback || errCallback){
            htmlArr.push('<div class="form-actions tac" style="margin:0; padding:10px 20px;">');
              if(succCallback){
              htmlArr.push('<button type="button" class="btn btn-small btn-success" id="propSubmit">');
                htmlArr.push('<i class="icon-ok bigger-110"></i>');
                htmlArr.push('确定');
              htmlArr.push('</button>');
              }
              if(errCallback){
              htmlArr.push('<button type="button" class="btn btn-small btn-default propCancel">');
                htmlArr.push('<i class="icon-undo bigger-110"></i>');
                htmlArr.push('返回');
              htmlArr.push('</button>');
              }
            htmlArr.push('</div>');
          }
          htmlArr.push('</div>');
      htmlArr.push('</div>');
    htmlArr.push('</div>');

    var newdom = $(htmlArr.join('\n'));
    newdom.find('#promptCon').html($(dom)[0].outerHTML);
    $('<div id="rq" style="width:1px; height:1px; overflow:hidden;"></div>').appendTo($('body'));
    $('#rq').append(newdom);
    var width = newdom.outerWidth();
    var height = newdom.outerHeight();
    $('#rq').remove();
    newdom.find('#propSubmit').on('click',function(){
      succCallback && succCallback();
    });
    newdom.find('.propCancel').on('click',function(){
      if(errCallback===true){
        $.unblockUI();
      }else{
        errCallback();
      }
    });
    $.blockUI({
      message: newdom,
      overlayCSS: {
        backgroundColor: "rgba(0,0,0,.8)"
      },
      css: {
        width: width,
        height: height,
        left: ($(window).width() - width) / 2,
        top: ($(window).height() - height) / 2,
        border: 'none',
        background: "transparent"
      }
    });
  };
 /**
   * @function
   * @memberOf Widget
   * @name bindDateTimeP
   * @description 日期＋时间
   * @param {dom} dom input所在的父元素
   */
  _result.bindDateTimeP = function(dom){
    var format = dom.attr("data-format") || 'yyyy-MM-dd hh:mm';
    dom.datetimepicker({
      format: format
    });
    dom.find('input').each(function(){
      $(this).attr("data-format",format);
      var value = $(this).val();
      if(!value) return;
      var timeobj = new Date(parseInt(value));
      var curval = DateTime.format(timeobj, format);
      $(this).val(curval);
    });
  };
  /**
   * @function
   * @memberOf Widget
   * @name bindDateTimeP
   * @description 日期
   * @param {dom} dom input所在的父元素
   */
  _result.bindDateP = function(dom){
    var format = dom.attr("data-format") || 'yyyy-MM-dd';
    dom.datetimepicker({
        format: format,
        pickTime: false
    })
    dom.find('input').each(function(){
      $(this).attr("data-format",format);
      var value = $(this).val();
      if(!value) return;
      var timeobj = new Date(parseInt(value));
      var curval = API.dateTimeAPI.format(timeobj, format);
      $(this).val(curval);

    });
  }
  /**
   * @function
   * @memberOf Widget
   * @name bindTimeP
   * @description 时间
   * @param {dom} dom input所在的父元素
   */
  _result.bindTimeP = function(dom){
    var format = dom.attr("data-format") || 'hh:mm';
    dom.datetimepicker({
      format: format,
        pickDate: false
    });
    dom.find('input').each(function(){
      $(this).attr("data-format",format);
      var value = $(this).val();
      if(!value) return;
      var timeobj = new Date(parseInt(value));
      var curval = API.dateTimeAPI.format(timeobj, format);
      $(this).val(curval);
    });
  }

  return _result;
});