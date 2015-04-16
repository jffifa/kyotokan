package util
{
   import a24.tween.Tween24;
   import flash.media.Sound;
   import common.debug.Debug;
   import common.util.DateTimeUtil;
   import common.util.SoundUtil;
   import flash.net.URLRequest;
   import flash.media.SoundTransform;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   
   public class TimeSignalVoice extends Object
   {
      
      public function TimeSignalVoice()
      {
         super();
      }
      
      private var _charaID:int = -1;
      
      private var _loadTween:Tween24 = null;
      
      private var _playVoiceTween:Tween24 = null;
      
      private var _nextVoice:Sound = null;
      
      private var _nextVoiceID:int = -1;
      
      private var _isLoadCompleteNext:Boolean = false;
      
      private var _preVoiceID:int = -1;
      
      public function initialize(param1:int) : void
      {
         if(_loadTween != null)
         {
            return;
         }
         if(_charaID != param1)
         {
            _clearCache();
         }
         _clearTween();
         _charaID = param1;
         var _loc2_:int = _getNextVoiceID();
         if(_nextVoice)
         {
            if(_nextVoiceID == _loc2_ && (_isLoadCompleteNext))
            {
               _createPlayTween();
               return;
            }
            _clearCache();
         }
         _createLoadTween();
         _createPlayTween();
      }
      
      public function finalize() : void
      {
         if(_loadTween)
         {
            _loadTween.stop();
            _loadTween = null;
         }
         if(_playVoiceTween)
         {
            _playVoiceTween.stop();
            _playVoiceTween = null;
         }
      }
      
      private function _createLoadTween() : void
      {
         var _loc9_:Number = new Date().getTime();
         var _loc2_:Number = _getNextVoiceTime();
         var _loc5_:Number = _loc2_ - _loc9_;
         var _loc7_:int = Math.floor(_loc5_ / 1000 / 60);
         Debug.log("次の時報まで: " + _loc7_ + "分" + Math.floor(_loc5_ / 1000 % 60) + "秒");
         var _loc3_:int = Math.min(25,Math.max(0,_loc7_ - 5));
         var _loc8_:Number = Math.random() * _loc3_ * 60 * 1000;
         var _loc6_:Number = _loc2_ - 300000;
         var _loc1_:Number = _loc6_ - _loc8_;
         var _loc4_:Number = Math.max(_loc1_ - _loc9_,0);
         Debug.log("時報ボイスの再生予定時間：" + DateTimeUtil.format(new Date(_loc2_)));
         Debug.log("時報ボイスの5分前：" + DateTimeUtil.format(new Date(_loc6_)));
         Debug.log("ランダム値：" + Math.floor(_loc8_ / 1000 / 60 * 100) / 100 + " -> " + DateTimeUtil.formatTime(_loc8_));
         Debug.log("+５分で" + Math.floor((_loc8_ / 1000 / 60 + 5) * 100) / 100 + " -> " + DateTimeUtil.formatTime(_loc8_ + 300000));
         Debug.log("現在時刻：" + DateTimeUtil.format(new Date(_loc9_)) + " 読み込み予定時刻" + DateTimeUtil.format(new Date(_loc1_)));
         Debug.log("時報サウンド読み込みまでおよそ" + DateTimeUtil.formatTime(_loc4_) + "待機");
         _loadTween = Tween24.wait(_loc4_ / 1000).onComplete(_loadVoice);
         _loadTween.play();
      }
      
      private function _createPlayTween() : void
      {
         var _loc3_:Number = new Date().getTime();
         var _loc2_:Number = _getNextVoiceTime();
         var _loc1_:Number = _loc2_ - _loc3_;
         Debug.log("時報再生までおよそ" + DateTimeUtil.formatTime(_loc1_) + "待機");
         _playVoiceTween = Tween24.wait(_loc1_ / 1000).onComplete(_playVoice);
         _playVoiceTween.play();
      }
      
      private function _loadVoice() : Boolean
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_nextVoice == null)
         {
            _nextVoiceID = _getNextVoiceID();
            _loc2_ = SoundUtil.getVoiceURL(_charaID,_nextVoiceID);
            try
            {
               _nextVoice = new Sound();
               _nextVoice.addEventListener("complete",_handleLoadCompleteVoice);
               _nextVoice.addEventListener("ioError",_handleLoadError);
               _loc1_ = new URLRequest(_loc2_);
               _nextVoice.load(_loc1_);
               var _loc4_:* = true;
               return _loc4_;
            }
            catch(error:Error)
            {
               Debug.log("time signal sound error:" + error);
            }
         }
         return false;
      }
      
      private function _playVoice() : void
      {
         var _loc1_:* = null;
         if(!(_nextVoice == null) && (_isLoadCompleteNext) && !(_preVoiceID == _nextVoiceID))
         {
            _loc1_ = new SoundTransform();
            _loc1_.volume = SoundUtil.volumeVoice;
            try
            {
               _nextVoice.play(0,0,_loc1_);
            }
            catch(error:Error)
            {
               Debug.log("time signal sound error2:" + error);
            }
            _preVoiceID = _nextVoiceID;
         }
         _loadTween = null;
         Tween24.wait(1).onComplete(initialize,_charaID).play();
      }
      
      private function _clearCache() : void
      {
         _clearTween();
         if(_nextVoice != null)
         {
            _nextVoice.removeEventListener("complete",_handleLoadCompleteVoice);
            _nextVoice.removeEventListener("ioError",_handleLoadError);
         }
         _nextVoice = null;
         _nextVoiceID = -1;
         _isLoadCompleteNext = false;
      }
      
      private function _clearTween() : void
      {
         if(_loadTween)
         {
            _loadTween.stop();
            _loadTween = null;
         }
         if(_playVoiceTween)
         {
            _playVoiceTween.stop();
            _playVoiceTween = null;
         }
      }
      
      private function _getNextVoiceID() : int
      {
         var _loc2_:Date = new Date();
         var _loc1_:int = _loc2_.hours + 1;
         _loc1_ = _loc1_ > 23?_loc1_ - 24:_loc1_;
         return _loc1_ + 30;
      }
      
      private function _getNextVoiceTime() : Number
      {
         var _loc2_:Number = new Date().getTime();
         var _loc1_:Date = new Date(_loc2_);
         var _loc3_:* = 0;
         _loc1_.milliseconds = _loc3_;
         _loc3_ = _loc3_;
         _loc1_.seconds = _loc3_;
         _loc1_.minutes = _loc3_;
         return _loc1_.getTime() + 3600000;
      }
      
      private function _handleLoadCompleteVoice(param1:Event) : void
      {
         Debug.log("時報ボイスの読み込み完了：" + (_nextVoiceID - 30) + "時用+[" + new Date() + "]");
         _isLoadCompleteNext = true;
      }
      
      private function _handleLoadError(param1:IOErrorEvent) : void
      {
         Debug.log("時報ボイスの読み込み失敗：" + (_nextVoiceID - 30) + "時用+[" + new Date() + "]");
      }
   }
}
