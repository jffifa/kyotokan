package manager.resource
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import common.debug.Debug;
   
   public class FurnitureImgAttacher extends EventDispatcher implements IFurnitureAttacher
   {
      
      public function FurnitureImgAttacher()
      {
         super();
         _stackList = new Vector.<ResourceImageLoader>();
      }
      
      private var _stackList:Vector.<ResourceImageLoader> = null;
      
      public function get nowLoading() : Boolean
      {
         return _stackList.length > 0 && (_stackList[0].nowLoading);
      }
      
      public function stack(param1:int, param2:int, param3:DisplayObjectContainer) : void
      {
      }
      
      public function stackThumbnail(param1:int, param2:int, param3:DisplayObjectContainer) : void
      {
      }
      
      public function stackFloor(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         param1--;
         var _loc8_:* = 0;
         var _loc5_:int = DataFacade.getMasterFurnitureData().getID(_loc8_,param1);
         var _loc4_:* = DataFacade.getStartData().getFurnitureAnimationType(_loc5_) > 0;
         var _loc7_:String = DataFacade.getStartData().getFurnitureFileName(_loc8_,param1);
         var _loc6_:String = DataFacade.getStartData().getFurnitureVersion(_loc8_,param1);
         var _loc9_:String = _createURLString("floor",_loc7_,_loc6_,param3,_loc4_);
         _stack(_loc9_,param2,_loc4_);
      }
      
      public function stackWall(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         param1--;
         var _loc8_:* = 1;
         var _loc5_:int = DataFacade.getMasterFurnitureData().getID(_loc8_,param1);
         var _loc4_:* = DataFacade.getStartData().getFurnitureAnimationType(_loc5_) > 0;
         var _loc7_:String = DataFacade.getStartData().getFurnitureFileName(_loc8_,param1);
         var _loc6_:String = DataFacade.getStartData().getFurnitureVersion(_loc8_,param1);
         var _loc9_:String = _createURLString("wall",_loc7_,_loc6_,param3,_loc4_);
         _stack(_loc9_,param2,_loc4_);
      }
      
      public function stackWindow(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         param1--;
         var _loc8_:* = 2;
         var _loc5_:int = DataFacade.getMasterFurnitureData().getID(_loc8_,param1);
         var _loc4_:* = DataFacade.getStartData().getFurnitureAnimationType(_loc5_) > 0;
         var _loc7_:String = DataFacade.getStartData().getFurnitureFileName(_loc8_,param1);
         var _loc6_:String = DataFacade.getStartData().getFurnitureVersion(_loc8_,param1);
         var _loc9_:String = _createURLString("window",_loc7_,_loc6_,param3,_loc4_);
         _stack(_loc9_,param2,_loc4_);
      }
      
      public function stackObject(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         param1--;
         var _loc8_:* = 3;
         var _loc5_:int = DataFacade.getMasterFurnitureData().getID(_loc8_,param1);
         var _loc4_:* = DataFacade.getStartData().getFurnitureAnimationType(_loc5_) > 0;
         var _loc7_:String = DataFacade.getStartData().getFurnitureFileName(_loc8_,param1);
         var _loc6_:String = DataFacade.getStartData().getFurnitureVersion(_loc8_,param1);
         var _loc9_:String = _createURLString("object",_loc7_,_loc6_,param3,_loc4_);
         _stack(_loc9_,param2,_loc4_);
      }
      
      public function stackChest(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         param1--;
         var _loc8_:* = 4;
         var _loc5_:int = DataFacade.getMasterFurnitureData().getID(_loc8_,param1);
         var _loc4_:* = DataFacade.getStartData().getFurnitureAnimationType(_loc5_) > 0;
         var _loc7_:String = DataFacade.getStartData().getFurnitureFileName(_loc8_,param1);
         var _loc6_:String = DataFacade.getStartData().getFurnitureVersion(_loc8_,param1);
         var _loc9_:String = _createURLString("chest",_loc7_,_loc6_,param3,_loc4_);
         _stack(_loc9_,param2,_loc4_);
      }
      
      public function stackDesk(param1:int, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         param1--;
         var _loc8_:* = 5;
         var _loc5_:int = DataFacade.getMasterFurnitureData().getID(_loc8_,param1);
         var _loc4_:* = DataFacade.getStartData().getFurnitureAnimationType(_loc5_) > 0;
         var _loc7_:String = DataFacade.getStartData().getFurnitureFileName(_loc8_,param1);
         var _loc6_:String = DataFacade.getStartData().getFurnitureVersion(_loc8_,param1);
         var _loc9_:String = _createURLString("desk",_loc7_,_loc6_,param3,_loc4_);
         _stack(_loc9_,param2,_loc4_);
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
      
      private function _stack(param1:String, param2:DisplayObjectContainer, param3:Boolean = false, param4:Class = null) : void
      {
         var _loc5_:ResourceImageLoader = new ResourceImageLoader(param1,param2,param3,param4);
         _stackList.push(_loc5_);
      }
      
      private function _nextLoad() : void
      {
         if(nowLoading)
         {
            return;
         }
         if(_stackList.length > 0)
         {
            _stackList[0].load(_loadComplete);
         }
         else
         {
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function _loadComplete(param1:String, param2:Boolean) : void
      {
         if(nowLoading)
         {
            return;
         }
         var _loc3_:ResourceImageLoader = _stackList.shift();
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
      
      private function _createURLString(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean = false) : String
      {
         var _loc6_:String = SettingFacade.URLROOT_GRAPHIC;
         _loc6_ = _loc6_ + ("image/furniture/" + param1);
         _loc6_ = _loc6_ + ("/" + param2 + (param4?"t":"") + (param5?".swf":".png"));
         if(param3 != "1")
         {
            _loc6_ = _loc6_ + ("?version=" + param3);
         }
         return _loc6_;
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
import flash.display.MovieClip;
import flash.events.IOErrorEvent;
import common.debug.Debug;
import flash.display.Bitmap;
import flash.events.TimerEvent;

class ResourceImageLoader extends Object
{
   
   function ResourceImageLoader(param1:String, param2:DisplayObjectContainer, param3:Boolean, param4:Class)
   {
      super();
      _urlReq = new URLRequest(param1);
      _urlLoader = new URLLoader();
      _timer = new Timer(5);
      _parent = param2;
      _isSWF = param3;
      _errorImgCls = param4;
   }
   
   private var _urlReq:URLRequest;
   
   private var _urlLoader:URLLoader;
   
   private var _timer:Timer;
   
   private var _parent:DisplayObjectContainer = null;
   
   private var _isSWF:Boolean;
   
   private var _errorImgCls:Class = null;
   
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
   
   private var _completeFunc:Function = null;
   
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
         if(_parent)
         {
            _parent.addChild(loader);
            if(_isSWF)
            {
               (loader.content as MovieClip).gotoAndStop(2);
               (loader.content as MovieClip).visible = true;
            }
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
      Debug.log(_urlReq.url);
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
      _timeouted = true;
      _nowLoading = false;
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
