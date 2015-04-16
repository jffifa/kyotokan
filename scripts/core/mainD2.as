package
{
   import flash.display.Sprite;
   import flash.display.Loader;
   import res.common.LoadingShipAnimation;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.net.URLRequest;
   import flash.net.URLLoader;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import flash.events.IOErrorEvent;
   
   public class mainD2 extends Sprite
   {
      
      public function mainD2()
      {
         super();
         _anim = new LoadingShipAnimation();
         _anim.x = 400;
         _anim.y = 240;
         addChild(_anim);
         _core = new Loader();
         addChild(_core);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(-800,-480,800,1440);
         _loc1_.graphics.drawRect(0,-480,800,480);
         _loc1_.graphics.drawRect(800,-480,800,1440);
         _loc1_.graphics.drawRect(0,480,800,480);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         addEventListener("addedToStage",_handleAddToStage);
      }
      
      private var _core:Loader;
      
      private var _anim:LoadingShipAnimation;
      
      protected function _handleFurnitureShowEnd(param1:Event) : void
      {
         _core.content.removeEventListener("Core:FurnitureShowEnd",_handleFurnitureShowEnd);
         removeChild(_anim);
      }
      
      private function _handleAddToStage(param1:Event) : void
      {
         event = param1;
         removeEventListener("addedToStage",_handleAddToStage);
         stage.addEventListener("contextMenu",function(param1:MouseEvent):void
         {
         });
         stage.stageFocusRect = false;
         var val:URLVariables = new URLVariables();
         val.version = "tfncmczotkbv";
         var req:URLRequest = new URLRequest("./Core.swf");
         req.method = "GET";
         req.data = val;
         var urlLoader:URLLoader = new URLLoader();
         urlLoader.dataFormat = "binary";
         urlLoader.addEventListener("complete",_handleLoadComplete);
         urlLoader.load(req);
      }
      
      private function _handleLoadComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         _loc2_.removeEventListener("complete",_handleLoadComplete);
         var _loc4_:ByteArray = _loc2_.data;
         var _loc3_:ByteArray = new ByteArray();
         var _loc6_:Object = _createKey();
         _core.contentLoaderInfo.addEventListener("complete",_handleLoadComplete2);
         _core.contentLoaderInfo.addEventListener("ioError",_handleLoadError);
         var _loc5_:LoaderContext = new LoaderContext();
         _loc5_.applicationDomain = ApplicationDomain.currentDomain;
         if(loaderInfo.loaderURL.match(new RegExp("^file:")) == null)
         {
            ___(_loc4_,_loc3_,_loc6_);
            _core.loadBytes(_loc3_,_loc5_);
         }
         else
         {
            _core.loadBytes(_loc4_,_loc5_);
         }
      }
      
      private function _handleLoadComplete2(param1:Event) : void
      {
         _core.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete2);
         _core.contentLoaderInfo.removeEventListener("ioError",_handleLoadError);
         try
         {
            _core.content["setSWFVer"](SwfVer.getSWFVersionsObject());
            _core.content["startApp"](loaderInfo.parameters);
            _core.content.addEventListener("Core:FurnitureShowEnd",_handleFurnitureShowEnd);
         }
         catch(e:ReferenceError)
         {
            trace(e);
         }
         catch(e:Error)
         {
            trace(e);
         }
      }
      
      private function _handleLoadError(param1:IOErrorEvent) : void
      {
         _core.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
         _core.contentLoaderInfo.removeEventListener("ioError",_handleLoadError);
      }
      
      private function _createKey() : Object
      {
         var key:Object = {};
         key.a = function(param1:int, param2:int):int
         {
            return param1 + param2;
         };
         key.s = function(param1:int, param2:int):int
         {
            return param1 - param2;
         };
         key.t = function(param1:int, param2:int):int
         {
            return param1 * param2;
         };
         key.d = function(param1:int, param2:int):int
         {
            return param1 / param2;
         };
         key.m = function(param1:int, param2:int):int
         {
            return param1 % param2;
         };
         key.f = function(param1:Number):int
         {
            return Math.floor(param1);
         };
         key.r = function():int
         {
            return Math.random();
         };
         key.j = function(... rest):String
         {
            return rest.join("");
         };
         key.n = function():Number
         {
            return new Date().getTime();
         };
         return key;
      }
      
      private function ___(param1:ByteArray, param2:ByteArray, param3:Object) : void
      {
         var _loc4_:* = this;
         param3[param3[new RegExp(".$")(new RegExp("....")(param3))](_loc4_,"")] = param3[new RegExp(".$")(new RegExp(" ...")({}))](new RegExp(".")(new RegExp(".. ")({})),new RegExp(".$")(new RegExp("..")({})),new RegExp(".")(new RegExp(".")([])),new RegExp(".")(new RegExp("..$")(!{})),new RegExp("...")(!!{}),new RegExp("..")(new RegExp(".. ")({})),new RegExp(".$")(new RegExp("..")({})),new RegExp(".$")(new RegExp("..")(!!{})));
         param3[~_loc4_] = ~_loc4_ >>> ~_loc4_;
         param3[param3[new RegExp(".")(new RegExp(".....$")(param3))]("",param3)] = ""[param3[_loc4_]];
         param3[new RegExp(".")(param3)] = ~_loc4_ / ~_loc4_ << ~_loc4_ / ~_loc4_ << ~_loc4_ / ~_loc4_;
         var _loc5_:* = param3[new RegExp(".")(param3)] << ~_loc4_ / ~_loc4_ << ~_loc4_ / ~_loc4_ | ~_loc4_ / ~_loc4_;
         param3[new RegExp(" .")((~~_loc4_)[param3[_loc4_]])] = _loc5_;
         param3[new RegExp(".")({})] = _loc5_;
         param3[new RegExp("..")([][{}])] = param3[new RegExp(".")(param3)][param3[new RegExp(".$")(new RegExp("....")({}))](new RegExp(".")(!!{}),new RegExp(".$")(new RegExp("..")({})),new RegExp(" (.*)]$")(param3[param3])[~_loc4_ / ~_loc4_])](~(~_loc4_ << (new RegExp(".")(new RegExp("..$")(~_loc4_ << ~_loc4_)) | ~_loc4_ << ~_loc4_ >>> ~_loc4_)));
         param3[new RegExp(".$")(!!{})] = param3[new RegExp(".$")(new RegExp(" ...")({}))](new RegExp(".$")(new RegExp(".")([])),new RegExp(".$")(!{}),new RegExp(".")(new RegExp(".")([])),new RegExp(".")(new RegExp(".....$")(new RegExp(".")[param3[_loc4_]])),new RegExp(".")(!!{}),param3[new RegExp("..")([][{}])]);
         param3[new RegExp(".")({})] = param3[new RegExp(".")(new RegExp(".....$")({}))](new RegExp(".")(!{}),new RegExp(".$")(new RegExp("..")(!!{})),new RegExp(".$")(new RegExp("..")(param3)),new RegExp(".$")(new RegExp(" ...")((~_loc4_)[param3[_loc4_]])),new RegExp(".$")(new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])),param3[new RegExp("..")([][{}])],new RegExp(".$")(new RegExp("..")(!{})),new RegExp(".$")(new RegExp("..")(!!{})),new RegExp(".$")(new RegExp(" .")(param3[param3[_loc4_]][param3[_loc4_]])),new RegExp(".$")(new RegExp("..")(param3)),new RegExp(".$")([][{}]),new RegExp(".$")(!{}));
         param3[new RegExp(".")({})] = param3[param3][param3[new RegExp(".")(param3)]];
         param3[new RegExp("..$")(___)] = param3[new RegExp(".$")(new RegExp("....")({}))](param3[param3](param3[_loc4_])[param3[new RegExp(".$")(!!{})]],new RegExp(".")(new RegExp("..$")(~_loc4_ >>> _loc4_)));
         param3[new RegExp("..$")(___)] = param3[new RegExp(".")(param3[param3])](param3[new RegExp("..$")(param3[new RegExp(".")(param3[param3])])]);
         param3[~~_loc4_] = param3[new RegExp(".$")(new RegExp("..")(!{}))](param3[~_loc4_],param3[~_loc4_]);
         param3[new RegExp(" .")({})] = param3[new RegExp(".")(new RegExp(".....$")(param3))](param3[new RegExp(".")({})](param3[new RegExp(" .")((~~_loc4_)[param3[_loc4_]])] * (param3[~_loc4_] << param3[~_loc4_] << param3[~_loc4_])),param3[new RegExp(".$")(new RegExp("....")(""[param3[_loc4_]]))](param3[~~_loc4_] | param3[~_loc4_],~_loc4_),new RegExp(".")("."),new RegExp(".")(new RegExp(". ")([][param3[_loc4_]][param3[_loc4_]])),param3[new RegExp("..$")(param3[new RegExp(".")(param3[param3])])],new RegExp(".")(!{}));
         param3[{}] = param3[new RegExp(".$")(new RegExp(" ...")({}))](param3[new RegExp("..$")(___)],new RegExp(".$")(new RegExp("..")(!!{})),new RegExp(".")(new RegExp("... ")(___)),new RegExp(".")(!!{}),new RegExp(".$")(!{}),new RegExp(".$")(new RegExp(" .")(param2[param3[_loc4_]])),new RegExp(".")(new RegExp("..$")([][param3[_loc4_]])),new RegExp(".")(!!{}),new RegExp(".$")(!{}),new RegExp(".")(new RegExp(". ")([][param3[_loc4_]])));
         param3[new RegExp(".$")(___)] = param3[~_loc4_] << (param3[new RegExp(".$")(new RegExp("..")(!{}))]("."[param3[_loc4_]](!{})[param3[new RegExp(".$")(!!{})]],param3[new RegExp(".")(!!{})](~_loc4_,"_"[param3[_loc4_]](!!{})[param3[new RegExp(".$")(!!{})]])) | param3[~~_loc4_] | param3[~_loc4_] << param3[~~_loc4_]);
         param3[new RegExp(".")(new RegExp("..$")(___))] = param3[~~~_loc4_] << (param3[~_loc4_] | param3[param3[new RegExp(".$")(new RegExp("..")(!{}))](~_loc4_,param3[new RegExp(".")(!!{})](~_loc4_,~_loc4_))]);
         param3[new RegExp(" .")([][param3[_loc4_]])] = param3[new RegExp(".")(new RegExp("..$")(!{}))](param1[param3[new RegExp(".$")(!!{})]],param3[new RegExp(".$")(param3[new RegExp(".$")(new RegExp("..")(!{}))])]);
         param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])] = param3[new RegExp(".$")([][{}])](param3[new RegExp(" .")([""][param3[_loc4_]])],param3[new RegExp(".")(new RegExp("..$")(param3[new RegExp(".")(new RegExp("..$")(!{}))]))]);
         param3[new RegExp(".")([][{}])] = param3[new RegExp(".$")(___)];
         param3[new RegExp(".$")[param3[_loc4_]]] = new RegExp(".")(new RegExp("....$")(!{}));
         param3[new RegExp("..")((!{})[param3[_loc4_]])] = new RegExp(".")(!!{});
         param2[param3[param3]](param1,~~_loc4_,param3[new RegExp(".")([][{}])]);
         param2[param3[param3]](param1,param3[new RegExp(".")(new RegExp("..$")(!!{}))],param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])]);
         param2[param3[param3]](param1,param3[param3[new RegExp("_")[param3[_loc4_]]]](param3[new RegExp(".")(new RegExp("..$")(!!{}))],param3[param3[new RegExp("..")([][param3[_loc4_]])]](param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])],param3[~_loc4_] << param3[~~_loc4_] | param3[~~_loc4_] | param3[~_loc4_])),param3[new RegExp(" .")({}[param3[_loc4_]][param3[_loc4_]])]);
         param2[param3[param3]](param1,param3[param3[new RegExp("..")[param3[_loc4_]]]](param3[new RegExp(".")([][{}])],param3[param3[new RegExp("..")(""[param3[_loc4_]])]](param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])],param3[~~_loc4_])),param3[new RegExp(" .")({}[param3[_loc4_]][param3[_loc4_]])]);
         param3[new RegExp("..$")(new RegExp(".")([]))] = param3[new RegExp(".$")(new RegExp("....")(param3))](new RegExp(".$")(new RegExp("...")(""[param3[_loc4_]])),new RegExp(".$")(new RegExp("..")({})),new RegExp(".$")(new RegExp("..")(!{})),new RegExp(".$")(new RegExp("...")([][{}])),new RegExp(".$")(!!{}),new RegExp(".$")(new RegExp(" ..")([][param3[_loc4_]])),param3[new RegExp(".")({})](param3[param3[new RegExp(".")[param3[_loc4_]]]](param3[param3[new RegExp("..")(new RegExp(".")[param3[_loc4_]])]](param3[new RegExp(" .")((~~_loc4_)[param3[_loc4_]])],""[param3[_loc4_]](!!{})[param3[new RegExp(".$")(!!{})]]),""[param3[_loc4_]](!{})[param3[new RegExp(".$")(!!{})]])),new RegExp(".")(new RegExp(".")([])),new RegExp(".")(!{}),new RegExp(".$")(new RegExp("..")({})));
         _loc4_[param3[new RegExp("..$")(new RegExp("_")([]))]][param3[new RegExp(".$")(new RegExp("....")({}))](new RegExp(".")([][{}]),new RegExp(".")(new RegExp("....$")([][param3[_loc4_]])),new RegExp(".")(new RegExp("...$")(!{})))][param3[new RegExp(".$")(new RegExp("....")({}))](new RegExp("..$")(!{}),new RegExp(".$")(new RegExp("..")(!{})),new RegExp(".$")(new RegExp("..")(!!{})),new RegExp(".$")(new RegExp("..")([][param3[_loc4_]])),param3[new RegExp("..")([][{}])])](param3[new RegExp(" .")(param3)]) > 0?param2[param3[param3]](param1,param3[param3[new RegExp(".")[param3[_loc4_]]]](param3[new RegExp(".")([][{}])],param3[param3[new RegExp("..")(""[param3[_loc4_]])]](param3[new RegExp(" .")({}[param3[_loc4_]][param3[_loc4_]])],param3[~~_loc4_] << param3[~_loc4_] | param3[~_loc4_])),param3[new RegExp(" .")({}[param3[_loc4_]][param3[_loc4_]])]):param2[param3[param3]](param1,param3[param3[new RegExp("|")[param3[_loc4_]]]](0,param3[param3[new RegExp("..")((~_loc4_)[param3[_loc4_]])]](param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])],param3[""[param3[new RegExp(".$")(!!{})]]] << param3[~_loc4_] | param3[~_loc4_])),param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])]);
         param2[param3[param3]](param1,param3[param3[new RegExp("$")[param3[_loc4_]]]](param3[new RegExp(".")([][{}])],param3[param3[new RegExp("..")([][param3[_loc4_]])]](param3[new RegExp(" .")([][param3[_loc4_]][param3[_loc4_]])],param3[new RegExp(".")(new RegExp("..$")(___))] >> param3[~_loc4_])),param3[new RegExp(" .")(""[param3[_loc4_]][param3[_loc4_]])]);
         param2[param3[param3]](param1,param3[param3[new RegExp("$")[param3[_loc4_]]]](param3[new RegExp(".")(new RegExp("..$")(!!{}))],param3[param3[new RegExp("..")([][param3[_loc4_]])]](param3[new RegExp(" .")(""[param3[_loc4_]][param3[_loc4_]])],param3[~_loc4_] | param3[~~_loc4_])),param3[new RegExp(" .")({}[param3[_loc4_]][param3[_loc4_]])]);
         param2[param3[param3]](param1,param3[param3[new RegExp("..$")[param3[_loc4_]]]](param3[new RegExp(".$")(new RegExp(" ..")((~_loc4_)[param3[_loc4_]]))],param3[param3[new RegExp("..")((~_loc4_)[param3[_loc4_]])]](param3[new RegExp(" .")("."[param3[_loc4_]][param3[_loc4_]])],param3[new RegExp(".$")(new RegExp(" ..")((~_loc4_)[param3[_loc4_]]))] >> (param3[~_loc4_] << param3[~~_loc4_] | param3[~_loc4_]) | param3[~~_loc4_])),param3[new RegExp(" .")("|"[param3[_loc4_]][param3[_loc4_]])]);
         param2[param3[param3]](param1,param3[param3[new RegExp("__")[param3[_loc4_]]]](param3[new RegExp(".")([][{}])],param3[param3[new RegExp("..")(""[param3[_loc4_]])]](param3[new RegExp(" .")("."[param3[_loc4_]][param3[_loc4_]])],param3[~_loc4_])),param3[new RegExp(" .")({}[param3[_loc4_]][param3[_loc4_]])]);
      }
   }
}
