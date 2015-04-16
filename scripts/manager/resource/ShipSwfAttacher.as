package manager.resource
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import common.Consts;
   import flash.events.Event;
   import common.debug.Debug;
   
   public class ShipSwfAttacher extends EventDispatcher implements IShipAttacher
   {
      
      public function ShipSwfAttacher()
      {
         super();
         _stackList = new Vector.<ResourceImageLoader>();
      }
      
      private var _stackList:Vector.<ResourceImageLoader> = null;
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && (_stackList[0].nowLoading);
      }
      
      public function stackCardS(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"4":"5",param2);
      }
      
      public function stackCardSS(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"2":"3",param2);
      }
      
      public function stackCharaLevel(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"12":"13",param2);
      }
      
      public function stackCharacterFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"8":"9",param2);
      }
      
      public function stackCharacterUp(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"6":"7",param2);
      }
      
      public function stackFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"10":"11",param2);
      }
      
      public function stackSupplyCharacter(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:Boolean = param3 <= 50 && (Consts.existTaihaImage(param1));
         _stack(param1,!_loc4_?"15":"16",param2);
      }
      
      public function stackStatusTopCharacter(param1:int, param2:DisplayObjectContainer) : void
      {
         _stack(param1,"14",param2);
      }
      
      public function load() : void
      {
         if(_stackList.length == 0)
         {
            dispatchEvent(new Event("complete"));
         }
         else
         {
            _nextLoad();
         }
      }
      
      public function cancel() : void
      {
         if(_stackList.length)
         {
            Debug.log("[ResourceImageManager] cancel.");
         }
         if(nowLoading)
         {
            _stackList[0].cancel();
         }
         _stackList = new Vector.<ResourceImageLoader>();
      }
      
      private function _stack(param1:int, param2:String, param3:DisplayObjectContainer) : void
      {
         var _loc4_:ResourceImageLoader = new ResourceImageLoader(param1,param2,param3);
         _stackList.push(_loc4_);
      }
      
      private function _nextLoad() : void
      {
         if(nowLoading || !_stackList.length)
         {
            return;
         }
         _stackList[0].load(_loadComplete);
      }
      
      private function _loadComplete() : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc1_:ResourceImageLoader = _stackList.shift();
         if(_stackList.length > 0)
         {
            _nextLoad();
         }
         else
         {
            dispatchEvent(new Event("complete"));
         }
      }
   }
}
import flash.net.URLRequest;
import flash.display.Loader;
import flash.utils.Timer;
import flash.display.DisplayObjectContainer;
import manager.CacheManager;
import flash.utils.ByteArray;
import common.debug.Debug;
import org.libspark.utils.ForcibleLoader;
import vo.StartData;
import flash.events.Event;
import flash.display.MovieClip;
import flash.events.IOErrorEvent;
import flash.events.TimerEvent;

class ResourceImageLoader extends Object
{
   
   function ResourceImageLoader(param1:int, param2:String, param3:DisplayObjectContainer)
   {
      super();
      _charaID = param1;
      _type = param2;
      var _loc4_:String = _createURLString(param1);
      _urlReq = new URLRequest(_loc4_);
      _parent = param3;
   }
   
   private var _charaID:int;
   
   private var _type:String;
   
   private var _urlReq:URLRequest;
   
   private var _loader:Loader;
   
   private var _timer:Timer;
   
   private var _parent:DisplayObjectContainer = null;
   
   private var _completeFunc:Function;
   
   private var _nowLoading:Boolean = false;
   
   private var _timeouted:Boolean = false;
   
   public function get url() : String
   {
      return _urlReq.url;
   }
   
   public function get nowLoading() : Boolean
   {
      return _nowLoading;
   }
   
   public function load(param1:Function) : void
   {
      var _loc2_:* = null;
      _nowLoading = true;
      _completeFunc = param1;
      _loader = new Loader();
      _timer = new Timer(5 * 1000,1);
      var _loc3_:ByteArray = CacheManager.getCacheShipResource(_charaID);
      if(_loc3_ != null)
      {
         Debug.log("From Cache : " + _charaID);
         _loader.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         _loader.loadBytes(_loc3_);
         _timer.addEventListener("timerComplete",_handleTimeOut);
      }
      else
      {
         _loader.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
         _loader.addEventListener("ioError",_handleIOErrorEvent);
         _timer.addEventListener("timerComplete",_handleTimeOut);
         _timer.start();
         _loc2_ = new ForcibleLoader(_loader);
         _loc2_.load(_urlReq);
      }
   }
   
   public function cancel() : void
   {
      Debug.log("[ResourceImageLoader] cancel.");
      if(_nowLoading)
      {
         _parent = null;
         try
         {
            _loader.close();
         }
         catch(error:Error)
         {
            _loader.unload();
         }
      }
   }
   
   private function _createURLString(param1:int) : String
   {
      var _loc2_:String = param1.toString();
      var _loc6_:* = 1;
      var _loc3_:StartData = DataFacade.getStartData();
      var _loc5_:String = _loc3_.getShipFileName(param1);
      if(!(_loc5_ == "") && SettingFacade.IGNORE_SHIP_FILENAME == false)
      {
         _loc2_ = _loc5_;
         _loc6_ = _loc3_.getShipVersion(param1);
      }
      var _loc4_:String = SettingFacade.URLROOT_GRAPHIC;
      _loc4_ = _loc4_ + ("swf/ships/" + _loc2_ + ".swf");
      if(_loc4_.match(new RegExp("file:.*")) == null)
      {
         _loc4_ = _loc4_ + ("?VERSION=" + _loc6_);
      }
      return _loc4_;
   }
   
   private function _handleLoadComplete(param1:Event = null) : void
   {
      _loader.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
      _loader.removeEventListener("ioError",_handleIOErrorEvent);
      _timer.removeEventListener("timerComplete",_handleTimeOut);
      var _loc2_:MovieClip = _loader.content as MovieClip;
      _loc2_.visible = true;
      var _loc3_:int = parseInt(_type);
      _loc2_.gotoAndStop(_loc3_);
      CacheManager.setCacheShipResource(_charaID,_loader);
      if(_parent)
      {
         _parent.addChild(_loader);
      }
      _nowLoading = false;
      if(!(_completeFunc == null) && _timeouted == false)
      {
         _completeFunc();
      }
   }
   
   private function _handleIOErrorEvent(param1:IOErrorEvent) : void
   {
      _loader.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
      _loader.removeEventListener("ioError",_handleIOErrorEvent);
      _timer.removeEventListener("timerComplete",_handleTimeOut);
      _nowLoading = false;
      Debug.log("[LoadError]" + url);
      if(!(_completeFunc == null) && _timeouted == false)
      {
         _completeFunc();
      }
   }
   
   private function _handleTimeOut(param1:TimerEvent) : void
   {
      _loader.contentLoaderInfo.removeEventListener("complete",_handleLoadComplete);
      _loader.removeEventListener("ioError",_handleIOErrorEvent);
      _timer.removeEventListener("timerComplete",_handleTimeOut);
      _nowLoading = false;
      _timeouted = true;
      Debug.log("[LoadError(timeout)]" + url);
      if(_completeFunc != null)
      {
         _completeFunc();
      }
   }
}
