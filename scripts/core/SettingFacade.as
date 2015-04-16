package
{
   import flash.events.EventDispatcher;
   import common.util.Util;
   import flash.net.SharedObject;
   import common.debug.Debug;
   import flash.display.LoaderInfo;
   import common.debug.DebugSettingLoader;
   
   public final class SettingFacade extends EventDispatcher
   {
      
      public function SettingFacade()
      {
         super();
         _settingData = {};
         var _loc1_:SharedObject = _getVolumeSharedObject();
         if(_loc1_)
         {
            if(_loc1_.data.hasOwnProperty("bgm") && !isNaN(_loc1_.data["bgm"]))
            {
               SOUND_VOLUME_BGM = (_loc1_.data["bgm"]) / 100;
               SOUND_VOLUME_SE = (_loc1_.data["se"]) / 100;
               SOUND_VOLUME_VOICE = (_loc1_.data["voice"]) / 100;
               FLG_RECOGNIZED_VOICE = _loc1_.data["flg_recognized"] == 1?true:false;
            }
            else
            {
               SOUND_VOLUME_BGM = 0.3;
               SOUND_VOLUME_SE = 0.4;
               SOUND_VOLUME_VOICE = 0.6;
               FLG_RECOGNIZED_VOICE = true;
            }
         }
      }
      
      private static var _settingData:Object;
      
      static function get settingData() : Object
      {
         return _settingData;
      }
      
      public static function toString() : String
      {
         return JSON.stringify(_settingData);
      }
      
      public static function get DEBUG() : Boolean
      {
         return Util.getBooleanFromInt(_settingData,"debug",false);
      }
      
      public static function set DEBUG(param1:Boolean) : void
      {
         _settingData["debug"] = param1;
      }
      
      public static function get EX_SETTING() : String
      {
         return Util.getString(_settingData,"exSetting");
      }
      
      public static function get IGNORE_SHIP_FILENAME() : Boolean
      {
         return Util.getInt(_settingData,"ignore_ship_filename") == 1;
      }
      
      public static function get API_TOKEN() : String
      {
         return Util.getString(_settingData,"api_token");
      }
      
      public static function set API_TOKEN(param1:String) : void
      {
         _settingData["api_token"] = param1;
      }
      
      public static function get URLROOT_API() : String
      {
         return Util.getString(_settingData,"url_root_api");
      }
      
      public static function set URLROOT_API(param1:String) : void
      {
         _settingData["url_root_api"] = param1;
      }
      
      public static function get URLROOT_GRAPHIC() : String
      {
         return Util.getString(_settingData,"url_root_graphic");
      }
      
      public static function set URLROOT_GRAPHIC(param1:String) : void
      {
         _settingData["url_root_graphic"] = param1;
      }
      
      public static function get URLROOT_SOUND() : String
      {
         return Util.getString(_settingData,"url_root_sound");
      }
      
      public static function get URLROOT_PURCHASE_IMAGE() : String
      {
         return Util.getString(_settingData,"url_root_purchase_image");
      }
      
      public static function get LOADER_URL() : String
      {
         return Util.getString(_settingData,"loader_url");
      }
      
      public static function get PROTOCOL_NAME() : String
      {
         return Util.getString(_settingData,"protocol_name");
      }
      
      public static function get DOMAIN_NAME() : String
      {
         return Util.getString(_settingData,"domain_name");
      }
      
      public static function get SWF_PATH() : String
      {
         return Util.getString(_settingData,"swf_path");
      }
      
      public static function get RES_TYPE_SHIP() : String
      {
         return Util.getString(_settingData,"res_ship");
      }
      
      public static function get RES_TYPE_SLOTITEM() : String
      {
         return Util.getString(_settingData,"res_slotitem");
      }
      
      public static function get RES_TYPE_USEITEM() : String
      {
         return Util.getString(_settingData,"res_useitem");
      }
      
      public static function get RES_TYPE_FURNITURE() : String
      {
         return Util.getString(_settingData,"res_furniture");
      }
      
      public static function get ANIMATION_TYPE() : int
      {
         return Util.getInt(_settingData,"animation_type");
      }
      
      public static function getURLROOT_API_Dummy(param1:String) : String
      {
         var _loc2_:Object = Util.getObject(_settingData,"dummy_api",{});
         return Util.getString(_loc2_,param1);
      }
      
      public static var SOUND_VOLUME_MASTER:Number = 1;
      
      public static var SOUND_VOLUME_BGM:Number = 0.3;
      
      public static var SOUND_VOLUME_SE:Number = 0.4;
      
      public static var SOUND_VOLUME_VOICE:Number = 0.6;
      
      public static var FLG_RECOGNIZED_VOICE:Boolean = true;
      
      private static function _getVolumeSharedObject() : SharedObject
      {
         return SharedObject.getLocal("volume_setting");
      }
      
      public static function saveVolumeData() : void
      {
         var _loc1_:* = null;
         var _loc2_:SharedObject = _getVolumeSharedObject();
         if(_loc2_)
         {
            try
            {
               _loc2_.data["bgm"] = Math.floor(SOUND_VOLUME_BGM * 100);
               _loc2_.data["se"] = Math.floor(SOUND_VOLUME_SE * 100);
               _loc2_.data["voice"] = Math.floor(SOUND_VOLUME_VOICE * 100);
               _loc2_.data["flg_recognized"] = FLG_RECOGNIZED_VOICE?1:0.0;
               Debug.log("size: " + _loc2_.size);
               _loc1_ = _loc2_.flush();
               var _loc4_:* = _loc1_;
               if("flushed" !== _loc4_)
               {
                  if("pending" === _loc4_)
                  {
                     Debug.log("save volume pending.");
                  }
               }
               else
               {
                  Debug.log("save volume. " + JSON.stringify(_loc2_.data));
               }
            }
            catch(e:Error)
            {
               Debug.log("Failed save volume.");
            }
         }
         else
         {
            Debug.log("ボリューム用のSharedObjectがありません。");
         }
         if(_loc2_)
         {
            return;
         }
      }
      
      public static function clearVolumeData() : void
      {
         var _loc1_:SharedObject = _getVolumeSharedObject();
         if(_loc1_)
         {
            _loc1_.clear();
         }
      }
      
      public function initialize(param1:Object, param2:Function) : void
      {
         flashVars = param1;
         completeFunc = param2;
         var loaderInfo:LoaderInfo = AppFacade.root.loaderInfo;
         var loaderURL:String = loaderInfo == null?"file:":loaderInfo.loaderURL;
         _createSetting(loaderURL);
         Util.overWrite(_settingData,flashVars);
         if(EX_SETTING.length > 0)
         {
            new DebugSettingLoader(_settingData,function():void
            {
            });
         }
         else
         {
            completeFunc();
         }
      }
      
      private function _createSetting(param1:String) : void
      {
         var _loc5_:* = null;
         var _loc6_:String = "";
         var _loc2_:String = "";
         var _loc4_:String = "";
         var _loc3_:Array = param1.match(new RegExp("^[^\\/:]+:"));
         if(!(_loc3_ == null) && _loc3_.length > 0)
         {
            _loc4_ = _loc3_[0];
         }
         if(_loc4_ == "http:" || _loc4_ == "https:")
         {
            _loc6_ = param1.match(new RegExp("^[httpsfile]+:\\/{2,3}[0-9a-z\\.\\-]+\\/","i"))[0];
            _loc5_ = param1.split("/");
            if(_loc5_ is Array)
            {
               _loc5_.pop();
               _loc2_ = _loc5_.join("/") + "/";
            }
         }
         _settingData = _createSettingBase(_loc6_,_loc2_);
         _settingData["loader_url"] = param1;
         _settingData["protocol_name"] = _loc4_;
         _settingData["domain_name"] = _loc6_;
         _settingData["swf_path"] = _loc2_;
         if(PROTOCOL_NAME == "app:" || PROTOCOL_NAME == "file:")
         {
            _settingData["exSetting"] = "setting.json";
         }
      }
      
      private function _createSettingBase(param1:String, param2:String) : Object
      {
         var _loc3_:Object = {
            "debug":0,
            "url_root_api":param1 + "kcsapi/",
            "url_root_graphic":param2 + "resources/",
            "url_root_purchase_image":param2 + "images/purchase_items/",
            "url_root_sound":param2 + "sound/",
            "res_ship":"swf",
            "res_slotitem":"image",
            "res_useitem":"image",
            "res_furniture":"image"
         };
         return _loc3_;
      }
   }
}
