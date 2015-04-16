package common.util
{
   import flash.utils.Dictionary;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import common.debug.Debug;
   import flash.events.Event;
   import a24.tween.Tween24;
   import flash.net.URLRequest;
   import flash.events.IOErrorEvent;
   
   public class SoundUtil extends Object
   {
      
      public function SoundUtil()
      {
         super();
      }
      
      public static var VOICE_MAX_SIDE_BY_SIDE:int = 1;
      
      private static var _playingBGMSounds:Dictionary = new Dictionary();
      
      private static var _playingVoices:Vector.<_SoundDTO> = null;
      
      public static function get volumeBGM() : Number
      {
         return SettingFacade.SOUND_VOLUME_MASTER * SettingFacade.SOUND_VOLUME_BGM;
      }
      
      public static function get volumeSE() : Number
      {
         return SettingFacade.SOUND_VOLUME_MASTER * SettingFacade.SOUND_VOLUME_SE;
      }
      
      public static function get volumeVoice() : Number
      {
         return SettingFacade.SOUND_VOLUME_MASTER * SettingFacade.SOUND_VOLUME_VOICE;
      }
      
      public static function playBGM(param1:String, param2:Sound, param3:Number = 0, param4:Boolean = false, param5:Function = null) : void
      {
         soundName = param1;
         sound = param2;
         startTime = param3;
         atOnce = param4;
         onPlayComplete = param5;
         if(sound == null)
         {
            if(_playingBGMSounds.hasOwnProperty(soundName))
            {
               var sound:Sound = _SoundDTO(_playingBGMSounds[soundName]).sound;
            }
            else
            {
               return;
            }
         }
         if(_playingBGMSounds.hasOwnProperty(soundName))
         {
            if(Object(_SoundDTO(_playingBGMSounds[soundName]).sound).constructor == Object(sound).constructor)
            {
               return;
            }
            stopBGM(soundName);
         }
         try
         {
            var soundChannel:SoundChannel = sound.play(startTime,0);
         }
         catch(error:ArgumentError)
         {
            Debug.log("BGM未ロード");
         }
         var volume:Number = volumeBGM;
         var soundTransform:SoundTransform = new SoundTransform(volume);
         if(soundChannel == null)
         {
            return;
         }
         soundChannel.soundTransform = soundTransform;
         if(atOnce == false)
         {
            var handleSoundComplete:Function = function(param1:Event):void
            {
               stopBGM(soundName);
               playBGM(soundName,sound);
            };
            soundChannel.addEventListener("soundComplete",handleSoundComplete);
         }
         else
         {
            var handleSoundCompleteAtOnce:Function = function(param1:Event):void
            {
               stopBGM(soundName);
               if(onPlayComplete != null)
               {
                  onPlayComplete(soundName);
               }
            };
            soundChannel.addEventListener("soundComplete",handleSoundCompleteAtOnce);
         }
         var vo:_SoundDTO = new _SoundDTO(sound,soundChannel);
         _playingBGMSounds[soundName] = vo;
      }
      
      public static function updateVolume() : void
      {
         var _loc3_:* = null;
         var _loc4_:* = NaN;
         var _loc1_:* = null;
         var _loc6_:* = 0;
         var _loc5_:* = _playingBGMSounds;
         for(var _loc2_ in _playingBGMSounds)
         {
            _loc3_ = _playingBGMSounds[_loc2_];
            _loc4_ = volumeBGM;
            _loc1_ = new SoundTransform(_loc4_);
            _loc3_.soundChannel.soundTransform = _loc1_;
         }
      }
      
      public static function stopBGM(param1:String) : Number
      {
         if(!_playingBGMSounds.hasOwnProperty(param1))
         {
            return 0;
         }
         var _loc3_:_SoundDTO = _playingBGMSounds[param1];
         var _loc2_:Number = _loc3_.soundChannel.position;
         _loc3_.soundChannel.stop();
         _playingBGMSounds[param1] = null;
         delete _playingBGMSounds[param1];
         true;
         return _loc2_;
      }
      
      public static function stopBGMFadeout(param1:String, param2:Number, param3:Function = null) : void
      {
         soundName = param1;
         time = param2;
         completeFunc = param3;
         if(!_playingBGMSounds.hasOwnProperty(soundName))
         {
            if(completeFunc != null)
            {
               completeFunc(0);
            }
            return;
         }
         var bgmSoundVo:_SoundDTO = _playingBGMSounds[soundName];
         var _fadeOutBGMSound:Function = function(param1:Number):void
         {
            var _loc2_:SoundTransform = new SoundTransform(param1);
            bgmSoundVo.soundChannel.soundTransform = _loc2_;
         };
         var volume:Number = volumeBGM;
         Tween24.tweenFunc(_fadeOutBGMSound,time,[volume],[0]).onComplete(function():void
         {
            var _loc1_:Number = SoundUtil.stopBGM(soundName);
            if(completeFunc != null)
            {
               completeFunc(_loc1_);
            }
         }).play();
      }
      
      public static function playSE(param1:Class) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Number = volumeSE;
         playSoundFromLinkage(param1,_loc2_);
      }
      
      public static function getVoiceURL(param1:int, param2:int) : String
      {
         var _loc3_:* = null;
         var _loc5_:* = 0;
         var _loc4_:* = null;
         if(SettingFacade.IGNORE_SHIP_FILENAME == true || param1 == 9998 || param1 == 9999)
         {
            return SettingFacade.URLROOT_SOUND + "kc" + param1 + "/" + param2 + ".mp3";
         }
         _loc3_ = DataFacade.getStartData().getShipFileName(param1);
         _loc5_ = DataFacade.getStartData().getShipVersion(param1);
         _loc4_ = "";
         if(_loc5_ > 1)
         {
            _loc4_ = "?version=" + (_loc5_);
         }
         return SettingFacade.URLROOT_SOUND + "kc" + _loc3_ + "/" + param2 + ".mp3" + _loc4_;
      }
      
      public static function playVoice(param1:int, param2:int, param3:Function = null, param4:Function = null) : SoundChannel
      {
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc10_:Number = volumeVoice;
         if(_loc10_ == 0)
         {
            return null;
         }
         Debug.log("[playVoice] charaID: " + param1 + " voiceID:" + param2);
         if(_playingVoices == null)
         {
            _playingVoices = new Vector.<_SoundDTO>();
         }
         while(_playingVoices.length > VOICE_MAX_SIDE_BY_SIDE - 1)
         {
            _loc5_ = _playingVoices.shift();
            if(_loc5_.soundChannel is SoundChannel)
            {
               _loc5_.soundChannel.stop();
            }
         }
         var _loc11_:String = getVoiceURL(param1,param2);
         var _loc7_:URLRequest = new URLRequest(_loc11_);
         var _loc9_:Sound = new Sound(_loc7_);
         var _loc6_:SoundChannel = _playSound(_loc9_,_loc10_,param3,param4);
         if(_loc6_ != null)
         {
            _loc8_ = new _SoundDTO(_loc9_,_loc6_);
            _playingVoices.push(_loc8_);
         }
         else
         {
            Debug.log("[playVoice Error] charaID: " + param1 + " voiceID:" + param2);
         }
         return _loc6_;
      }
      
      public static function playVoiceAtRandom(param1:int, param2:Array, param3:Array) : SoundChannel
      {
         var _loc7_:* = 0;
         var _loc4_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < param3.length)
         {
            _loc4_ = _loc4_ + param3[_loc7_];
            _loc7_++;
         }
         var _loc5_:* = 0;
         var _loc6_:Number = Math.random() * _loc4_;
         _loc7_ = 0;
         while(_loc7_ < param3.length)
         {
            _loc5_ = _loc5_ + param3[_loc7_];
            if(_loc6_ <= _loc5_)
            {
               return playVoice(param1,param2[_loc7_]);
            }
            _loc7_++;
         }
         return null;
      }
      
      public static function stopAllVoices() : void
      {
         var _loc1_:* = null;
         if(_playingVoices == null)
         {
            _playingVoices = new Vector.<_SoundDTO>();
         }
         while(_playingVoices.length > 0)
         {
            _loc1_ = _playingVoices.shift();
            _loc1_.soundChannel.stop();
         }
      }
      
      public static function playSoundFromLinkage(param1:Class, param2:Number, param3:Function = null) : SoundChannel
      {
         var _loc4_:Sound = new param1();
         return _playSound(_loc4_,param2,param3);
      }
      
      public static function playSound(param1:String, param2:Number, param3:Function = null, param4:Function = null) : SoundChannel
      {
         var _loc5_:URLRequest = new URLRequest(param1);
         var _loc6_:Sound = new Sound(_loc5_);
         return _playSound(_loc6_,param2,param3,param4);
      }
      
      private static function _playSound(param1:Sound, param2:Number, param3:Function = null, param4:Function = null) : SoundChannel
      {
         sound = param1;
         volume = param2;
         soundCompleteFunc = param3;
         errorFunc = param4;
         var soundChannel:SoundChannel = sound.play(0,0);
         var soundTransform:SoundTransform = new SoundTransform(volume);
         if(soundChannel == null)
         {
            if(errorFunc != null)
            {
               errorFunc(new Error("[Error] SoundUtil::PlaySound(no soundChannel) - " + sound.url));
            }
            return null;
         }
         soundChannel.soundTransform = soundTransform;
         var handleSoundComplete:Function = function(param1:Event):void
         {
            soundChannel.removeEventListener("soundComplete",handleSoundComplete);
            sound.removeEventListener("ioError",handleIOError);
            if(soundCompleteFunc != null)
            {
               soundCompleteFunc();
            }
         };
         var handleIOError:Function = function(param1:IOErrorEvent):void
         {
            soundChannel.removeEventListener("soundComplete",handleSoundComplete);
            sound.removeEventListener("ioError",handleIOError);
            if(errorFunc != null)
            {
               errorFunc(new Error("[Error] SoundUtil::PlaySound - " + sound.url));
            }
         };
         sound.addEventListener("ioError",handleIOError);
         soundChannel.addEventListener("soundComplete",handleSoundComplete);
         return soundChannel;
      }
   }
}
import flash.media.Sound;
import flash.media.SoundChannel;

class _SoundDTO extends Object
{
   
   function _SoundDTO(param1:Sound, param2:SoundChannel)
   {
      super();
      this.sound = param1;
      this.soundChannel = param2;
   }
   
   public var sound:Sound;
   
   public var soundChannel:SoundChannel;
   
   public var nowVolume:Number = 1;
}
