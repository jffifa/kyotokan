package connection.api_port
{
   import connection.APIConnectionBase;
   import flash.events.Event;
   import vo.UseItemData;
   
   public class PortAPI extends APIConnectionBase
   {
      
      public function PortAPI(param1:Array = null)
      {
         super();
         _API_NAME = "母港TOP用新API";
         _url = "api_port/port";
         _actionLog = param1;
      }
      
      private var _actionLog:Array;
      
      private function __(param1:Number, param2:Object) : String
      {
         var _loc4_:* = null;
         var _loc5_:* = this;
         var _loc3_:int = param2.u(param2.i(new RegExp("..")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) << (new RegExp(".$")(~[][{}] << ~[][{}]) | ~[][{}] >>> ~[][{}])),new RegExp(".$")(~[][{}] << ~[][{}]) << new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(~(~[][{}] << ~[][{}])));
         _loc4_ = param2.t(param2.s(param2.u(param2.z(param2.u(param2.i(new RegExp(".$")(~[][{}] << ~[][{}]) | ~[][{}] >>> ~[][{}]),~[][{}] >>> ~[][{}]),Il[param2.b(param2.s(_loc5_))]),param2.l(param2.s(param1),param2.m(param2.w(),new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]),new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}])))))),param2.z(param2.m(param2.u(param2.m(param2.z(param2.u(Il[new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]],_loc3_),param2.u(param2.l(param2.s(param1),~~[][{}],param2.x()),Il[param2.b(param2.s(_loc5_))])),param2.n()),param2.u(Il[new RegExp(".$")(~[][{}] << ~[][{}]) << ~[][{}] >>> ~[][{}] | ~[][{}] >>> ~[][{}]],param2.z(new RegExp(".$")(~[][{}] << ~[][{}]) | ~[][{}] >>> ~[][{}],_loc3_))),param1),Il[I1(param2.p(new RegExp(".$")(~[][{}] << ~[][{}]) | new RegExp(".")(~(~[][{}] << ~[][{}])),param1),param2)]),param2.s(param2.u(param2.i(param2.z(new RegExp(".$")(~[][{}] << ~[][{}]) | ~[][{}] >>> ~[][{}],Il[param2.z(param2.j(),new RegExp(".")(~(~[][{}] << ~[][{}])))])),Il[param2.v()])),_loc3_);
         return _loc4_;
      }
      
      private function I1(param1:int, param2:Object) : int
      {
         var _loc3_:* = 0;
         while(param1 != param2.l(param2.s(param2.y(Il[Il[new RegExp(".$")(~[][{}] << ~[][{}]) | param2.x() | ~[][{}] >>> ~[][{}]]])),_loc3_,~[][{}] >>> ~[][{}]))
         {
            _loc3_++;
         }
         return _loc3_;
      }
      
      private const Il:Array = [new RegExp(".........")(~(~[][{}] << ~[][{}])) >> new RegExp("..$")(new RegExp("...")(~(~[][{}] << ~[][{}]))) & ~(new RegExp("..")(new RegExp("......$")(~(~[][{}] << ~[][{}]))) << new RegExp(".$")(~[][{}] << ~[][{}])) | new RegExp("..")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) << (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]),(new RegExp("..")(new RegExp("......$")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | new RegExp("..")(new RegExp("......$")(~(~[][{}] << ~[][{}])))) << new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) | new RegExp("..")(new RegExp(".....$")(~(~[][{}] << ~[][{}]))) >> ~[][{}] >>> ~[][{}],new RegExp(".")(~(~[][{}] << ~[][{}])) | (new RegExp("..")(~(~[][{}] << ~[][{}])) << new RegExp(".")(~(~[][{}] << ~[][{}])) | ~[][{}] >>> ~[][{}]) << (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]),new RegExp("....")(~(~[][{}] << ~[][{}])) & ~(new RegExp(".$")(~[][{}] << ~[][{}]) << new RegExp(".")(~(~[][{}] << ~[][{}]))) | new RegExp("...")(~(~[][{}] << ~[][{}])) >> new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))),new RegExp(".....$")(new RegExp("......")(~(~[][{}] << ~[][{}]))) >> (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]) << new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}],(new RegExp("..$")(new RegExp("....")(~(~[][{}] << ~[][{}]))) | (new RegExp(".$")(~(~[][{}] << ~[][{}])) << new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) | new RegExp(".$")(~(~[][{}] << ~[][{}]))) << (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]) << ~[][{}] >>> ~[][{}]) << new RegExp(".")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) | new RegExp("..")(~(~[][{}] << ~[][{}])) | new RegExp("..")(~(~[][{}] << ~[][{}])) >> ~[][{}] >>> ~[][{}],new RegExp("..")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) << new RegExp(".$")(~(~[][{}] << ~[][{}])) | ~[][{}] >>> ~[][{}] | new RegExp("..$")(new RegExp("....")(~(~[][{}] << ~[][{}]))) >> new RegExp(".")(~(~[][{}] << ~[][{}])) << new RegExp(".")(new RegExp("...$")(~(~[][{}] << ~[][{}]))),new RegExp("..")(new RegExp("......$")(~(~[][{}] << ~[][{}]))) | new RegExp("..")(new RegExp("......$")(~(~[][{}] << ~[][{}]))) << new RegExp(".$")(~(~[][{}] << ~[][{}])) | ~[][{}] >>> ~[][{}],new RegExp("..")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) << new RegExp(".$")(~(~[][{}] << ~[][{}])) | new RegExp("..")(~(~[][{}] << ~[][{}])) | new RegExp("..")(new RegExp("...$")(~(~[][{}] << ~[][{}]))),(new RegExp("..$")(new RegExp(".....")(~(~[][{}] << ~[][{}]))) >> new RegExp(".")(~(~[][{}] << ~[][{}])) << new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | new RegExp("..")(~(~[][{}] << ~[][{}]))) << (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]),new RegExp(".$")(~[][{}] << ~[][{}]) | new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}],new RegExp("...")(~(~[][{}] << ~[][{}])) >> new RegExp(".")(~(~[][{}] << ~[][{}])) << new RegExp(".$")(~(~[][{}] << ~[][{}])) | new RegExp("..$")(new RegExp("...")(~(~[][{}] << ~[][{}]))),new RegExp("...")(new RegExp("......$")(~(~[][{}] << ~[][{}]))) >> (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]) | new RegExp("...$")(new RegExp(".....")(~(~[][{}] << ~[][{}]))) >> new RegExp(".")(~(~[][{}] << ~[][{}])) << (new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | ~[][{}] >>> ~[][{}]),new RegExp(".")(~(~[][{}] << ~[][{}])) | new RegExp(".$")(~[][{}] << ~[][{}]),new RegExp("..")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) << new RegExp(".$")(~(~[][{}] << ~[][{}])) | new RegExp("..$")(new RegExp("....")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(new RegExp("..$")(~(~[][{}] << ~[][{}]))) | new RegExp("..")(~(~[][{}] << ~[][{}])) >> ~[][{}] >>> ~[][{}] | ~[][{}] >>> ~[][{}],new RegExp("..")(~(~[][{}] << ~[][{}])) >> ~[][{}] >>> ~[][{}] | ~[][{}] >>> ~[][{}] | new RegExp("...")(~(~[][{}] << ~[][{}])) >> new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) << new RegExp(".$")(~(~[][{}] << ~[][{}])),new RegExp("..$")(new RegExp("...")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(new RegExp("...$")(~(~[][{}] << ~[][{}]))) | new RegExp("...")(~(~[][{}] << ~[][{}])) >> new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(~(~[][{}] << ~[][{}])),new RegExp(".......$")(~(~[][{}] << ~[][{}])) >> new RegExp(".$")(~(~[][{}] << ~[][{}])) << ~[][{}] >>> ~[][{}] << new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(~(~[][{}] << ~[][{}])) | new RegExp("..")(new RegExp("......$")(~(~[][{}] << ~[][{}]))) >> ~[][{}] >>> ~[][{}] | ~[][{}] >>> ~[][{}] | new RegExp("....")(new RegExp(".....$")(~(~[][{}] << ~[][{}]))) >> new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}]))) << new RegExp(".")(new RegExp("....$")(~(~[][{}] << ~[][{}])))];
      
      override protected function _preLoad() : void
      {
         _urlVariables.api_sort_key = "5";
         _urlVariables.spi_sort_order = "2";
         var _loc2_:Object = _createKey();
         var _loc1_:int = parseInt(DataFacade.getUserData().getMemberID());
         _urlVariables.api_port = __(_loc1_,_loc2_);
      }
      
      override protected function _handleLoadComplete(param1:Event, param2:Object) : void
      {
         var _loc9_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc12_:* = null;
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc10_:* = null;
         var _loc7_:* = null;
         if(param2.hasOwnProperty("api_ship") && (param2.hasOwnProperty("api_deck_port")))
         {
            _loc9_ = param2["api_ship"] as Array;
            if(_loc9_ != null)
            {
               DataFacade.getUserDeckData().setShipData(_loc9_);
               _loc5_ = param2["api_deck_port"] as Array;
               if(_loc5_ != null)
               {
                  DataFacade.getUserDeckData().setDeckData(_loc5_);
               }
               else
               {
                  AppFacade.showErrorScreen("api_get_member/ship2 must return \"decks\" array data.");
                  return;
               }
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/ship2 must return \"ships\" array data.");
               return;
            }
         }
         if(param2.hasOwnProperty("api_ndock"))
         {
            _loc3_ = param2["api_ndock"] as Array;
            if(_loc3_ != null)
            {
               DataFacade.getRepairDockData().setData(_loc3_);
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/ndock must return array data.");
            }
         }
         if(param2.hasOwnProperty("api_material"))
         {
            _loc8_ = param2["api_material"] as Array;
            if(_loc8_ != null)
            {
               _loc4_ = DataFacade.getUseItemData();
               _loc4_.setMaterial(_loc8_);
            }
            else
            {
               AppFacade.showErrorScreen("api_get_member/material must return array data.");
            }
         }
         if(param2.hasOwnProperty("api_basic"))
         {
            DataFacade.getUserData().setData(param2["api_basic"]);
         }
         if(!(_actionLog == null) && (param2.hasOwnProperty("api_log")))
         {
            _loc12_ = param2["api_log"] as Array;
            if(_loc12_ != null)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc12_.length)
               {
                  _actionLog.push(_loc12_[_loc11_]);
                  _loc11_++;
               }
            }
         }
         if(param2.hasOwnProperty("api_combined_flag"))
         {
            _loc6_ = param2["api_combined_flag"];
            DataFacade.getUserDeckData().setCombinedFlag(_loc6_);
         }
         if(param2.hasOwnProperty("api_p_bgm_id"))
         {
            _loc10_ = param2["api_p_bgm_id"];
            DataFacade.getUserData().setPortMainBGMID(_loc10_);
         }
         if(param2.hasOwnProperty("api_event_object"))
         {
            _loc7_ = param2["api_event_object"];
            DataFacade.getUserData().setEventObj(_loc7_);
         }
      }
      
      private function _createKey() : Object
      {
         var key:Object = {};
         key.b = function(param1:String):int
         {
            return param1.length;
         };
         key.r = function(param1:Number):int
         {
            return Math.floor(param1);
         };
         key.i = function(param1:int):int
         {
            return key.r(Math.random() * param1);
         };
         key.j = function():int
         {
            return 8;
         };
         key.k = function(param1:Number, param2:Number):Number
         {
            return param1 ^ param2;
         };
         key.l = function(param1:String, param2:int, param3:int):int
         {
            return parseInt(param1.substr(param2,param3));
         };
         key.m = function(param1:Number, param2:Number):Number
         {
            return param1 - param2;
         };
         key.n = function():Number
         {
            return key.r(new Date().getTime() / 1000);
         };
         key.o = function(param1:Number, param2:Number):Number
         {
            return param2 / param1;
         };
         key.p = function(param1:Number, param2:Number):Number
         {
            return param2 % param1;
         };
         key.q = function():Number
         {
            return 1.4426950408889634;
         };
         key.s = function(param1:Object):String
         {
            return param1.toString();
         };
         key.t = function(... rest):String
         {
            return rest.join("");
         };
         key.u = function(param1:Number, param2:Number):Number
         {
            return param1 + param2;
         };
         key.v = function():int
         {
            return 16;
         };
         key.w = function():int
         {
            return 2;
         };
         key.x = function():int
         {
            return 4;
         };
         key.y = function(param1:int):Number
         {
            return Math.sqrt(param1);
         };
         key.z = function(param1:Number, param2:Number):Number
         {
            return param1 * param2;
         };
         return key;
      }
   }
}
