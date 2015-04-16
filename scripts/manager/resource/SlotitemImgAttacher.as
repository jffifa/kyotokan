package manager.resource
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import common.debug.Debug;
   import common.util.MathUtil;
   
   public class SlotitemImgAttacher extends EventDispatcher implements ISlotitemAttacher
   {
      
      public function SlotitemImgAttacher()
      {
         super();
         _stackList = new Vector.<ResourceImageLoader>();
      }
      
      private var _stackList:Vector.<ResourceImageLoader> = null;
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && (_stackList[0].nowLoading);
      }
      
      public function stackCard(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("card",param1);
         _stack(_loc3_,param2);
      }
      
      public function stackItemOn(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("item_on",param1);
         _stack(_loc3_,param2);
      }
      
      public function stackItemCharacter(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("item_character",param1);
         _stack(_loc3_,param2);
      }
      
      public function stackItemUp(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("item_up",param1);
         _stack(_loc3_,param2);
      }
      
      public function stackStatusTop(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("statustop_item",param1);
         _stack(_loc3_,param2);
      }
      
      public function stackRemodel(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("remodal",param1);
         _stack(_loc3_,param2);
      }
      
      public function stackBtxt(param1:int, param2:DisplayObjectContainer, param3:Boolean = true) : void
      {
         var _loc4_:String = _createURLString(param3?"btxt_flat":"btxt_tilt",param1);
         _stack(_loc4_,param2);
      }
      
      public function stackChara(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:* = param3 <= 25;
         var _loc5_:String = _createURLString("chara_level_" + (_loc4_?"d":"n"),param1);
         _stack(_loc5_,param2);
      }
      
      public function stackCharacterFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:* = param3 <= 25;
         var _loc5_:String = _createURLString("character_full_" + (_loc4_?"d":"n"),param1);
         _stack(_loc5_,param2);
      }
      
      public function stackCharacterUp(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:* = param3 <= 25;
         var _loc5_:String = _createURLString("character_up_" + (_loc4_?"d":"n"),param1);
         _stack(_loc5_,param2);
      }
      
      public function stackFull(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:* = param3 <= 25;
         var _loc5_:String = _createURLString("full_" + (_loc4_?"d":"n"),param1);
         _stack(_loc5_,param2);
      }
      
      public function stackSupplyCharacter(param1:int, param2:DisplayObjectContainer, param3:int = 100) : void
      {
         var _loc4_:* = param3 <= 25;
         var _loc5_:String = _createURLString("supply_character_" + (_loc4_?"d":"n"),param1);
         _stack(_loc5_,param2);
      }
      
      public function stackStatusTopCharacter(param1:int, param2:DisplayObjectContainer) : void
      {
         var _loc3_:String = _createURLString("statusTop_character_n",param1);
         _stack(_loc3_,param2);
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
      
      private function _stack(param1:String, param2:DisplayObjectContainer, param3:Class = null) : void
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
      
      private function _loadComplete(param1:String, param2:Boolean) : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc4_:ResourceImageLoader = _stackList.shift();
         var _loc3_:String = param1.match(new RegExp("(\\/[^\\/]*\\/\\d+\\.png)"))[1];
         param2?Debug.log("[ResourceImageManager] Load Complete(" + _stackList.length + "). - " + _loc3_):Debug.log("[ResourceImageManager] Load IOError(" + _stackList.length + "). - " + _loc3_);
         if(_stackList.length > 0)
         {
            _nextLoad();
         }
         else
         {
            Debug.log("[ResourceImageManager] Load Complete ALL.");
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function _createURLString(param1:String, param2:int) : String
      {
         var _loc3_:String = SettingFacade.URLROOT_GRAPHIC;
         _loc3_ = _loc3_ + ("image/slotitem/" + param1);
         _loc3_ = _loc3_ + ("/" + MathUtil.digit3(param2) + ".png");
         return _loc3_;
      }
   }
}
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.utils.Timer;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.utils.ByteArray;
import flash.display.Loader;
import flash.display.Bitmap;
import flash.events.IOErrorEvent;
import flash.events.TimerEvent;
import common.debug.Debug;

class ResourceImageLoader extends Object
{
   
   function ResourceImageLoader(param1:String, param2:DisplayObjectContainer, param3:Class)
   {
      super();
      _urlReq = new URLRequest(param1);
      _urlLoader = new URLLoader();
      _timer = new Timer(5);
      _parent = param2;
      _errorImgCls = param3;
   }
   
   private var _urlReq:URLRequest;
   
   private var _urlLoader:URLLoader;
   
   private var _timer:Timer;
   
   private var _parent:DisplayObjectContainer = null;
   
   private var _errorImgCls:Class = null;
   
   private var _nowLoading:Boolean = false;
   
   private var _timeouted:Boolean = false;
   
   private var _completeFunc:Function = null;
   
   public function get url() : String
   {
      return _urlReq.url;
   }
   
   public function get nowLoading() : Boolean
   {
      return _nowLoading;
   }
   
   public function load(param1:Function, param2:Class = null) : void
   {
      _completeFunc = param1;
      _nowLoading = true;
      _urlLoader.dataFormat = "binary";
      _urlLoader.addEventListener("complete",_handleLoadComplete);
      _urlLoader.addEventListener("ioError",_handleIOErrorEvent);
      _urlLoader.load(_urlReq);
      _timer.addEventListener("timerComplete",_handleTimeOut);
   }
   
   public function cancel() : void
   {
      if(_nowLoading)
      {
         _urlLoader.close();
      }
   }
   
   private function _handleLoadComplete(param1:Event) : void
   {
      event = param1;
      _urlLoader.removeEventListener("complete",_handleLoadComplete);
      _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
      _timer.removeEventListener("timerComplete",_handleTimeOut);
      _nowLoading = false;
      var urlLoader:URLLoader = event.target as URLLoader;
      var bytes:ByteArray = urlLoader.data;
      var loader:Loader = new Loader();
      loader.loadBytes(bytes);
      loader.contentLoaderInfo.addEventListener("complete",function():void
      {
         loader.contentLoaderInfo.removeEventListener("complete",arguments.callee);
         bytes.clear();
         (loader.content as Bitmap).smoothing = true;
         if(_parent)
         {
            _parent.addChild(loader);
         }
         if(!(_completeFunc == null) && _timeouted == false)
         {
            _completeFunc(_urlReq.url,true);
         }
      });
   }
   
   private function _handleIOErrorEvent(param1:IOErrorEvent) : void
   {
      _urlLoader.removeEventListener("complete",_handleLoadComplete);
      _urlLoader.removeEventListener("ioError",_handleIOErrorEvent);
      _timer.removeEventListener("timerComplete",_handleTimeOut);
      _nowLoading = false;
      trace(_urlReq.url);
      if(_parent && _errorImgCls)
      {
         _parent.addChild(new Bitmap(new _errorImgCls()));
      }
      if(!(_completeFunc == null) && _timeouted == false)
      {
         _completeFunc(_urlReq.url,false);
      }
   }
   
   private function _handleTimeOut(param1:TimerEvent) : void
   {
      _timer.removeEventListener("timerComplete",_handleTimeOut);
      _nowLoading = false;
      _timeouted = true;
      Debug.log("[timeout] " + _urlReq.url);
      if(_parent && _errorImgCls)
      {
         _parent.addChild(new Bitmap(new _errorImgCls()));
      }
      if(_completeFunc != null)
      {
         _completeFunc(_urlReq.url,false);
      }
   }
}
