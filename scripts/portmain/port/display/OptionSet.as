package port.display
{
   import res.port.MCOptionSet;
   import common.display.FadeLayer;
   import a24.tween.Tween24;
   import flash.events.Event;
   import common.util.SoundUtil;
   import manager.BGMManager;
   import flash.events.MouseEvent;
   
   public class OptionSet extends MCOptionSet
   {
      
      public function OptionSet()
      {
         super();
         _fadeLayer = new FadeLayer();
         addChildAt(_fadeLayer,0);
         _sliderBGM = new Slider(OptionDialogMC.MCSliderBGM,"BGM");
         _sliderSE = new Slider(OptionDialogMC.MCSliderSE,"SE");
         _sliderVoice = new Slider(OptionDialogMC.MCSliderVoice,"VOICE");
         _recognizedVoiceSwitch = new RecognizedVoiceSwitch(OptionDialogMC.sw);
         OptionBtnMC.buttonMode = true;
         OptionBtnMC.addEventListener("click",_handleClickOptionBtn);
         addEventListener("click",_handleClickOptionSet);
         addEventListener("mouseMove",_handleMouseMove);
         _close(false);
      }
      
      public static const EVENT_OPTION_OPEN:String = "PORT::OPTION::OPEN";
      
      public static const EVENT_OPTION_CLOSE:String = "PORT::OPTION::CLOSE";
      
      private var _fadeLayer:FadeLayer;
      
      private var _opened:Boolean = false;
      
      private var _sliderBGM:Slider;
      
      private var _sliderSE:Slider;
      
      private var _sliderVoice:Slider;
      
      private var _recognizedVoiceSwitch:RecognizedVoiceSwitch;
      
      private var _tween:Tween24 = null;
      
      public function setState(param1:*) : void
      {
         visible = param1 == 0;
      }
      
      private function _open() : void
      {
         _tween = Tween24.serial(Tween24.func(_initDialog),_fadeLayer.getTween(0,0),Tween24.visible(true,_fadeLayer),Tween24.parallel(_fadeLayer.getTween(0.8,0.6),Tween24.tween(OptionDialogMC,0.2).xy(708,221),Tween24.tween(OptionDialogMC,0.2).alpha(1).delay(0.1)),Tween24.func(function():void
         {
            _opened = true;
            dispatchEvent(new Event("PORT::OPTION::OPEN"));
         }));
         _tween.onComplete(function():void
         {
            _tween = null;
         }).play();
      }
      
      private function _close(param1:Boolean) : void
      {
         needSoundBGM = param1;
         var needSoundBGM:Boolean = needSoundBGM && SoundUtil.volumeBGM > 0;
         var needSoundSE:Boolean = SoundUtil.volumeSE > 0 && AppFacade.root.isLoadedSoundSE() == false;
         _tween = Tween24.serial(Tween24.parallel(_fadeLayer.getTween(0,0.6),Tween24.tween(OptionDialogMC,0.2).xy(962,514),Tween24.tween(OptionDialogMC,0.2).alpha(0).delay(0.1)),AppFacade.root.loadSoundBGMTween(needSoundBGM),AppFacade.root.loadSoundSETween(needSoundSE),Tween24.func(function():void
         {
            var _loc1_:* = null;
            _opened = false;
            _fadeLayer.visible = false;
            SettingFacade.saveVolumeData();
            if(needSoundBGM == true)
            {
               if(BGMManager.JUKEBOX_SOUND != null)
               {
                  _loc1_ = BGMManager.JUKEBOX_SOUND;
               }
               else
               {
                  _loc1_ = DataFacade.getUserData().getPortMainBGMID();
               }
               BGMManager.playPortBGM(_loc1_);
            }
            dispatchEvent(new Event("PORT::OPTION::CLOSE"));
         }));
         _tween.onComplete(function():void
         {
            _tween = null;
         }).play();
      }
      
      private function _initDialog() : void
      {
         var _loc2_:Number = _sliderBGM.init();
         var _loc3_:Number = _sliderSE.init();
         var _loc1_:Number = _sliderVoice.init();
         _recognizedVoiceSwitch.updateState(SettingFacade.FLG_RECOGNIZED_VOICE);
      }
      
      private function _handleClickOptionBtn(param1:MouseEvent) : void
      {
         if(_tween != null)
         {
            return;
         }
         param1.stopImmediatePropagation();
         if(_opened)
         {
            _close(true);
         }
         else
         {
            _open();
         }
      }
      
      private function _handleClickOptionSet(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
      
      private function _handleMouseMove(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
   }
}
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import common.util.SoundUtil;

class Slider extends Object
{
   
   function Slider(param1:MovieClip, param2:String)
   {
      super();
      _mc = param1;
      _type = param2;
      _mc.thumb.buttonMode = true;
      _mc.thumb.addEventListener("mouseDown",_handleThumbDown);
      _mc.icon.addEventListener("click",_handleClickIcon);
   }
   
   private var _mc:MovieClip;
   
   private var _type:String = "";
   
   public function init() : Number
   {
      var _loc1_:* = NaN;
      if(_type == "BGM")
      {
         _loc1_ = SettingFacade.SOUND_VOLUME_BGM;
      }
      else if(_type == "SE")
      {
         _loc1_ = SettingFacade.SOUND_VOLUME_SE;
      }
      else
      {
         _loc1_ = SettingFacade.SOUND_VOLUME_VOICE;
      }
      
      var _loc2_:* = _loc1_ * _mc.bar.width;
      _mc.thumb.x = _loc2_;
      _mc.bar.x = _loc2_;
      _mc.icon.gotoAndStop(_loc1_ <= 0?2:1.0);
      return _loc1_;
   }
   
   private function _handleThumbDown(param1:MouseEvent) : void
   {
      _mc.parent.addEventListener("mouseMove",_handleThumbMove);
      _mc.parent.addEventListener("mouseUp",_handleThumbUp);
      _mc.parent.addEventListener("rollOut",_handleThumbUp);
   }
   
   private function _handleThumbMove(param1:MouseEvent) : void
   {
      var _loc3_:Point = _mc.globalToLocal(new Point(param1.stageX,0));
      var _loc2_:Number = Math.min(Math.max(_loc3_.x,0),_mc.bar.width);
      var _loc4_:* = _loc2_;
      _mc.thumb.x = _loc4_;
      _mc.bar.x = _loc4_;
      _mc.icon.gotoAndStop(_loc2_ / _mc.bar.width <= 0?2:1.0);
      if(_type == "BGM")
      {
         SettingFacade.SOUND_VOLUME_BGM = _mc.bar.x / _mc.bar.width;
         SoundUtil.updateVolume();
      }
      else if(_type == "SE")
      {
         SettingFacade.SOUND_VOLUME_SE = _mc.bar.x / _mc.bar.width;
      }
      else
      {
         SettingFacade.SOUND_VOLUME_VOICE = _mc.bar.x / _mc.bar.width;
      }
      
   }
   
   private function _handleThumbUp(param1:MouseEvent) : void
   {
      _mc.parent.removeEventListener("mouseMove",_handleThumbMove);
      _mc.parent.removeEventListener("mouseUp",_handleThumbUp);
      _mc.parent.removeEventListener("rollOut",_handleThumbUp);
      if(_type == "BGM")
      {
         trace("BGM Volume: " + _mc.bar.x / _mc.bar.width);
      }
      else if(_type == "SE")
      {
         trace("SE Volume: " + _mc.bar.x / _mc.bar.width);
      }
      else
      {
         trace("Voice Volume: " + _mc.bar.x / _mc.bar.width);
      }
      
   }
   
   private function _handleClickIcon(param1:MouseEvent) : void
   {
      var _loc3_:* = 0;
      _mc.thumb.x = _loc3_;
      _mc.bar.x = _loc3_;
      var _loc2_:* = 0.0;
      _mc.icon.gotoAndStop(_loc2_ / _mc.bar.width <= 0?2:1.0);
      if(_type == "BGM")
      {
         SettingFacade.SOUND_VOLUME_BGM = _mc.bar.x / _mc.bar.width;
         SoundUtil.updateVolume();
      }
      else if(_type == "SE")
      {
         SettingFacade.SOUND_VOLUME_SE = _mc.bar.x / _mc.bar.width;
      }
      else
      {
         SettingFacade.SOUND_VOLUME_VOICE = _mc.bar.x / _mc.bar.width;
      }
      
   }
}
import flash.display.MovieClip;
import a24.tween.Tween24;
import common.util.MCUtil;
import flash.events.MouseEvent;

class RecognizedVoiceSwitch extends Object
{
   
   function RecognizedVoiceSwitch(param1:MovieClip)
   {
      super();
      _mc = param1;
      _mc.buttonMode = true;
      _mc.stop();
      setState(SettingFacade.FLG_RECOGNIZED_VOICE);
      _mc.addEventListener("click",_handleClick);
   }
   
   private var _mc:MovieClip;
   
   private var _nowAnimation:Boolean = false;
   
   public function setState(param1:Boolean) : void
   {
      value = param1;
      SettingFacade.FLG_RECOGNIZED_VOICE = value;
      _nowAnimation = true;
      if(SettingFacade.FLG_RECOGNIZED_VOICE)
      {
         _mc.gotoAndStop(1);
         var t:Tween24 = MCUtil.frameTween(_mc,1,8);
      }
      else
      {
         _mc.gotoAndStop(8);
         t = MCUtil.frameTween(_mc,8,15);
      }
      t.onComplete(function():void
      {
         _nowAnimation = false;
      }).play();
   }
   
   public function updateState(param1:Boolean) : void
   {
      if(param1)
      {
         _mc.gotoAndStop(8);
      }
      else
      {
         _mc.gotoAndStop(1);
      }
   }
   
   private function _handleClick(param1:MouseEvent) : void
   {
      if(_nowAnimation)
      {
         return;
      }
      setState(!SettingFacade.FLG_RECOGNIZED_VOICE);
   }
}
