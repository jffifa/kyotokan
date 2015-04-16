package common.util
{
   import flash.events.EventDispatcher;
   import a24.tween.Tween24;
   import flash.events.Event;
   
   public class BGMLoader extends EventDispatcher
   {
      
      public function BGMLoader(param1:String, param2:int = 0, param3:Function = null)
      {
         super();
         _soundName = param1;
         _startTime = param2;
         _onPlayComplete = param3;
      }
      
      private var _soundName:String;
      
      private var _startTime:int;
      
      private var _onPlayComplete:Function;
      
      private var _bgmID:String;
      
      private var _bgmCls:Class;
      
      private var _playSoon:Boolean = true;
      
      public function get bgmCls() : Class
      {
         return _bgmCls;
      }
      
      public function getTween(param1:String, param2:Boolean = true) : Tween24
      {
         _bgmID = param1;
         _playSoon = param2;
         return Tween24.parallel(Tween24.waitEvent(this,"complete"),Tween24.func(_load));
      }
      
      public function play(param1:int = 0) : void
      {
         fadeoutTime = param1;
         if(!(_bgmCls == null) && _bgmCls is Class)
         {
            if(fadeoutTime > 0)
            {
               SoundUtil.stopBGMFadeout(_soundName,fadeoutTime,function(param1:int):void
               {
                  _play();
               });
            }
            else
            {
               _play();
            }
         }
      }
      
      private function _play() : void
      {
         var _loc1_:* = !(_onPlayComplete == null);
         if(_loc1_)
         {
            SoundUtil.playBGM(_soundName,new _bgmCls(),_startTime,true,_onPlayComplete);
         }
         else
         {
            SoundUtil.playBGM(_soundName,new _bgmCls(),_startTime);
         }
      }
      
      private function _load(param1:int = 0) : void
      {
         var _loc2_:* = null;
         if(SoundUtil.volumeBGM == 0)
         {
            SoundUtil.stopBGM(_soundName);
            dispatchEvent(new Event("complete"));
            return;
         }
         var _loc3_:String = "res.sounds.BGM_" + _bgmID;
         _bgmCls = Assets.getBGMCls(_loc3_);
         if(_bgmCls == null)
         {
            if(param1 >= 3)
            {
               SoundUtil.stopBGM(_soundName);
               dispatchEvent(new Event("complete"));
               return;
            }
            _loc2_ = new _BGMLoader(_loc3_);
            _loc2_.getTween().onComplete(_load,param1 + 1).play();
         }
         else if(_playSoon == true)
         {
            play();
            dispatchEvent(new Event("complete"));
         }
         else
         {
            dispatchEvent(new Event("complete"));
         }
         
      }
   }
}
import flash.events.EventDispatcher;
import flash.display.Loader;
import a24.tween.Tween24;
import common.debug.Debug;
import flash.system.LoaderContext;
import flash.system.ApplicationDomain;
import common.util.Util;
import common.util.SwfVer;
import flash.net.URLRequest;
import flash.events.Event;

class _BGMLoader extends EventDispatcher
{
   
   function _BGMLoader(param1:String)
   {
      super();
      _bgmClassName = param1;
   }
   
   private var _bgmClassName:String;
   
   private var _loader:Loader;
   
   public function getTween() : Tween24
   {
      return Tween24.parallel(Tween24.waitEvent(this,"complete"),Tween24.func(start));
   }
   
   public function start() : void
   {
      var _loc6_:* = null;
      Debug.log("[BGMLoader  - start - " + _bgmClassName);
      var _loc4_:LoaderContext = new LoaderContext();
      _loc4_.applicationDomain = ApplicationDomain.currentDomain;
      var _loc3_:String = _bgmClassName.split(".").reverse()[0];
      var _loc2_:String = _loc3_.split("_")[1];
      if(_loc2_.search(new RegExp("^\\d+$")) != -1)
      {
         _loc6_ = SettingFacade.URLROOT_GRAPHIC + "bgm_p/" + Util.f(parseInt(_loc2_)) + ".swf";
      }
      else
      {
         _loc6_ = SettingFacade.URLROOT_GRAPHIC + "bgm_p/" + _loc2_ + ".swf";
      }
      var _loc1_:String = SwfVer.getBGM_P_Ver("" + _loc2_);
      _loc1_ = _loc1_?"?version=" + _loc1_:"";
      var _loc5_:URLRequest = new URLRequest(_loc6_ + _loc1_);
      _loader = new Loader();
      _loader.contentLoaderInfo.addEventListener("complete",_handleLoadComplete);
      _loader.contentLoaderInfo.addEventListener("ioError",_handleIOError);
      _loader.load(_loc5_,_loc4_);
   }
   
   private function _handleLoadComplete(param1:Event) : void
   {
      Debug.log("[BGMLoader  - loaded -" + _bgmClassName);
      param1.target.removeEventListener("complete",_handleLoadComplete);
      param1.target.removeEventListener("ioError",_handleIOError);
      _end();
   }
   
   private function _handleIOError(param1:Event) : void
   {
      Debug.log("[BGMLoader  - not loaded -" + _bgmClassName);
      param1.target.removeEventListener("complete",_handleLoadComplete);
      param1.target.removeEventListener("ioError",_handleIOError);
      _end();
   }
   
   private function _end() : void
   {
      Debug.log("[BGMLoader  - end -" + _bgmClassName);
      dispatchEvent(new Event("complete"));
   }
}
