
define(function(require, exports, module) {
  var FW = require("../breeze/framework/js/BreezeFW");
  require("../breeze/framework/js/tools/DateTime")(FW);
  FW.register(
    {
      param:{
        alias:'activities'
      },
      name:'activitiesMgrGadget',
      onCreate:function(){
        var _this = this;
        _this.API.show('viewActivitiesMgr');
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

