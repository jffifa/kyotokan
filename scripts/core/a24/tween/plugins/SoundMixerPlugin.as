package a24.tween.plugins
{
   import a24.tween.core.plugins.PulginTween24;
   import flash.media.SoundMixer;
   
   public class SoundMixerPlugin extends PulginTween24
   {
      
      public function SoundMixerPlugin()
      {
         super();
         _property = _property || new SoundMixerTween24Property();
      }
      
      private static var _property:SoundMixerTween24Property;
      
      public static function tween(param1:Number, param2:Function = null) : SoundMixerPlugin
      {
         var _loc3_:SoundMixerPlugin = new SoundMixerPlugin();
         _loc3_.setTween(_property,param1,param2);
         return _loc3_;
      }
      
      public static function prop() : SoundMixerPlugin
      {
         var _loc1_:SoundMixerPlugin = new SoundMixerPlugin();
         _loc1_.setProp(_property);
         return _loc1_;
      }
      
      public static function allStop() : SoundMixerPlugin
      {
         var _loc1_:SoundMixerPlugin = new SoundMixerPlugin();
         _loc1_.setFunc(SoundMixer.stopAll);
         return _loc1_;
      }
      
      public function volume(param1:Number) : SoundMixerPlugin
      {
         addParam("volume",param1);
         return this;
      }
      
      public function pan(param1:Number) : SoundMixerPlugin
      {
         addParam("pan",param1);
         return this;
      }
      
      public function leftToLeft(param1:Number) : SoundMixerPlugin
      {
         addParam("leftToLeft",param1);
         return this;
      }
      
      public function leftToRight(param1:Number) : SoundMixerPlugin
      {
         addParam("leftToRight",param1);
         return this;
      }
      
      public function rightToLeft(param1:Number) : SoundMixerPlugin
      {
         addParam("rightToLeft",param1);
         return this;
      }
      
      public function rightToRight(param1:Number) : SoundMixerPlugin
      {
         addParam("rightToRight",param1);
         return this;
      }
      
      public function delay(param1:Number) : SoundMixerPlugin
      {
         _tween.delay(param1);
         return this;
      }
      
      public function onPlay(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onPlay.apply(_tween,rest);
         return this;
      }
      
      public function onDelay(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onDelay.apply(_tween,rest);
         return this;
      }
      
      public function onInit(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onInit.apply(_tween,rest);
         return this;
      }
      
      public function onUpdate(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onUpdate.apply(_tween,rest);
         return this;
      }
      
      public function onPause(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onPause.apply(_tween,rest);
         return this;
      }
      
      public function onStop(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onStop.apply(_tween,rest);
         return this;
      }
      
      public function onComplete(param1:Function, ... rest) : SoundMixerPlugin
      {
         rest.unshift(param1);
         _tween.onComplete.apply(_tween,rest);
         return this;
      }
   }
}
import a24.tween.core.plugins.PluginTween24Property;
import flash.media.SoundTransform;
import flash.media.SoundMixer;

class SoundMixerTween24Property extends PluginTween24Property
{
   
   function SoundMixerTween24Property()
   {
      super();
      this._soundTransform = SoundMixer.soundTransform;
      this._volume = this._soundTransform.volume;
      this._pan = this._soundTransform.pan;
      this._leftToLeft = this._soundTransform.leftToLeft;
      this._leftToRight = this._soundTransform.leftToRight;
      this._rightToLeft = this._soundTransform.rightToLeft;
      this._rightToRight = this._soundTransform.rightToRight;
   }
   
   private var _soundTransform:SoundTransform;
   
   private var _volume:Number;
   
   private var _pan:Number;
   
   private var _leftToLeft:Number;
   
   private var _leftToRight:Number;
   
   private var _rightToLeft:Number;
   
   private var _rightToRight:Number;
   
   override public function atUpdate() : void
   {
      SoundMixer.soundTransform = this._soundTransform;
   }
   
   override public function atComplete() : void
   {
      this.atUpdate();
   }
   
   public function get volume() : Number
   {
      return this._volume;
   }
   
   public function set volume(param1:Number) : void
   {
      this._volume = param1;
      this._soundTransform.volume = this._volume;
   }
   
   public function get pan() : Number
   {
      return this._pan;
   }
   
   public function set pan(param1:Number) : void
   {
      this._pan = param1;
      this._soundTransform.pan = this.pan;
   }
   
   public function get leftToLeft() : Number
   {
      return this._leftToLeft;
   }
   
   public function set leftToLeft(param1:Number) : void
   {
      this._leftToLeft = param1;
      if(this._soundTransform)
      {
         this._soundTransform.leftToLeft = param1;
      }
   }
   
   public function get leftToRight() : Number
   {
      return this._leftToRight;
   }
   
   public function set leftToRight(param1:Number) : void
   {
      this._leftToRight = param1;
      if(this._soundTransform)
      {
         this._soundTransform.leftToRight = param1;
      }
   }
   
   public function get rightToLeft() : Number
   {
      return this._rightToLeft;
   }
   
   public function set rightToLeft(param1:Number) : void
   {
      this._rightToLeft = param1;
      if(this._soundTransform)
      {
         this._soundTransform.rightToLeft = param1;
      }
   }
   
   public function get rightToRight() : Number
   {
      return this._rightToRight;
   }
   
   public function set rightToRight(param1:Number) : void
   {
      this._rightToRight = param1;
      if(this._soundTransform)
      {
         this._soundTransform.rightToRight = param1;
      }
   }
}
